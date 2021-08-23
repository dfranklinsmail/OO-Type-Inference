Class {
	#name : #TypeInferenceTests,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
TypeInferenceTests >> testSmallIntegerMethodAssignAndReturnTyping [

| aMethod expectedType x |
aMethod := Mthd new.
aMethod selector: #number.
x:= (Asn varname: #x expression: (Int new)).
aMethod statements add: x.
aMethod statements add: (Rtrn exp: (Var varname: #x)).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: nil)equals: expectedType.

]

{ #category : #tests }
TypeInferenceTests >> testSmallIntegerMethodLastStatementTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.
aMethod statements add: (Int new).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: nil) equals: expectedType.



]

{ #category : #tests }
TypeInferenceTests >> testSmallIntegerMethodReturnTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.
aMethod statements add: (Rtrn exp: (Int new)).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: nil) equals: expectedType.



]
