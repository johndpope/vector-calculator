//
//  ViewController.swift
//  voice-calculator
//
//  Created by lz on 5/31/18.
//  Copyright © 2018 Zhuang Liu. All rights reserved.
//

import UIKit
import Speech
import PythonAPI
import PerfectPython
import Pythonic



class ViewController: UIViewController,SFSpeechRecognizerDelegate {
    Py_Initialize()
    //physical calculator declaration
    var typingNumber = false
    var display = ""
    var operation = ""
    
    //speech recognizer declaration
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh-CN"))

    //struct a stack data structure
    struct Stack {
        fileprivate var array: [String] = []
        mutating func push(_ element: String) {
            array.append(element)
        }
        mutating func pop() -> String? {
            return array.popLast()
        }
        mutating func count() ->Int {
            return array.count
        }
    }
    var stack = Stack()
    
    //////////////////viewDidLoad() divider//////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text=nil
        
        microphoneButton.isEnabled = false  //2
        
        speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    //////////////////viewDidLoad() divider//////////////

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var microphoneButton: UIButton!
    
    //number buttons and dot button pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        if typingNumber == true {
            let input = sender.currentTitle!
            if sender.currentTitle != "." && sender.currentTitle != "0" {
            textField.text = textField.text!+input
                print(textField.text ?? 1)
            } else {
                if textField.text != nil {
                    textField.text = textField.text!+input
                    typingNumber = true
                }
            }
        } else {
            textField.text=sender.currentTitle!
                typingNumber=true
        }
    }
    // clean button pressed
    @IBAction func clean(_ sender: UIButton) {
        textField.text=nil
    }
    //deleteDigit button pressed
    @IBAction func deleteDigit(_ sender: UIButton) {
        if(textField.text != ""){
        textField.text?.remove(at: (textField.text?.index(before: (textField.text?.endIndex)!))!)
        }
    }
    //operation button pressed
    
    @IBAction func operation(_ sender: UIButton) {
        operation = sender.currentTitle!
        if typingNumber {
            enter()
        }
        stack.push(textField.text!)
    }
    
    //negative button pressed
    @IBAction func negative(_ sender: UIButton) {
        if textField.text != nil && (textField.text?.contains("."))!{
            var number = Double(textField.text!)! * -1
            textField.text = String(number)
        } else if textField.text != nil{
            var number = Int(textField.text!)! * -1
            textField.text = String(number)
        }
    }
    //equal button pressed
    @IBAction func equal(_ sender: UIButton) {
        print(stack.count())
        print(operation)
        if typingNumber {
            stack.push(textField.text!)
        }
        if stack.count() >= 2 {
            let operand1 = Double(stack.pop()!)
            let operand2 = Double(stack.pop()!)
            print("hhh", (operand2! / operand1!).truncatingRemainder(dividingBy: 1))
            if operation == "÷" {
                display = String(operand2! / operand1!)
                if(operand2! / operand1!).truncatingRemainder(dividingBy: 1)==0{
                    display = String(Int(operand2! / operand1!))
                    print(Int(operand2! / operand1!))
                }
            }
            if operation == "x" {
                display = String(operand2! * operand1!)
                if(operand2! * operand1!).truncatingRemainder(dividingBy: 1)==0{
                    display = String(Int(operand2! * operand1!))
                }
            }
            if operation == "-" {
                display = String(operand2! - operand1!)
                if(operand2! - operand1!).truncatingRemainder(dividingBy: 1)==0{
                    display = String(Int(operand2! - operand1!))
                }
            }
            if operation == "+" {
                display = String(operand2! + operand1!)
                if(operand2! + operand1!).truncatingRemainder(dividingBy: 1)==0{
                    display = String(Int(operand2! + operand1!))
                }
            }
            operation = ""
            enter()
        }
        print(display)
        textField.text = String(display)
    }
    func enter() {
        typingNumber = false
        stack.push(textField.text!)
    }

    /////////////////////////////////////RECORDING UPPER DIVIDER//////////////////////////////////
    
    @IBAction func microphoneTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            microphoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode 
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.textField.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textField.text = "Say something, I'm listening!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    ////////////////////////////////////RECORDING LOWER DIVIDER//////////////////////////////////

}

extension String {
    func encodedOffset(of character: Character) -> Int? {
        return index(of: character)?.encodedOffset
    }
    func encodedOffset(of string: String) -> Int? {
        return range(of: string)?.lowerBound.encodedOffset
    }
    func indexOf(_ target: Character) -> Int? {
        return self.index(of: target)?.encodedOffset
    }
}
extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
