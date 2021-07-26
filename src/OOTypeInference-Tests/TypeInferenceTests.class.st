Class {
	#name : #TypeInferenceTests,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
TypeInferenceTests >> testSmallIntegerMethodReturnTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.
aMethod statements add: (Int new).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: nil)equals: expectedType.





]
