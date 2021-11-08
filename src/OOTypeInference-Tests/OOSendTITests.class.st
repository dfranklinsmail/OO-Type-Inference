Class {
	#name : #OOSendTITests,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
OOSendTITests >> testSameInterface [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	| send target |
	target := Cls new.
	send := Send new.
	send target: target.
	send selector: #add.
	
	self assert: (send typeOf: Dictionary new) equals: (send typeOf: Dictionary new).
]

{ #category : #tests }
OOSendTITests >> testSendMessage [ 
	"what should the type of a send be?
	Is it like a method or is it like a class
	A send has no implementation, just descriptive"
	| target send expectedType |
	target := Cls new.
	send := Send new.
	send target: target.
	send selector: #add.
	
	expectedType := TInterface new.
	expectedType addSelector: #add.
	
	self assert: (send typeOf: Dictionary new) equals: expectedType.
]

{ #category : #tests }
OOSendTITests >> testSendMessageNotEqual [
	"what should the type of a send be?
	Is it like a method or is it like a class
	A send has no implementation, just descriptive"
	| target send expectedType |
	target := Cls new.
	send := Send new.
	send target: target.
	send selector: #add.
	
	expectedType := TInterface new.
	expectedType addSelector: #subtract.
	
	self deny: (send typeOf: Dictionary new) equals: expectedType.
]
