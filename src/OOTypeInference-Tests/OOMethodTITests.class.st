Class {
	#name : #OOMethodTITests,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
OOMethodTITests >> testAssignmentTypeOf [

| x expectedType |
	x:= (Asn varname: #x expression: (Int new)).
	expectedType := TCls class: (Int class).
	self assert: (x typeOf: Dictionary new) equals: expectedType.


]

{ #category : #tests }
OOMethodTITests >> testIntegerArgumentAndReturnMethodTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.

aMethod addArgument: (Asn varname: #y expression: (Int new)).

aMethod addStatement: (Asn varname: #x expression: (Int new)).
aMethod addStatement: (Rtrn exp: (Var varname: #x)).

expectedType := TArrow type: (TCls class: (Int class))  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.


]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerMethodAssignAndReturnTyping [

| aMethod expectedType x |
aMethod := Mthd new.
aMethod selector: #number.
x:= (Asn varname: #x expression: (Int new)).
aMethod addStatement: x.
aMethod addStatement: (Rtrn exp: (Var varname: #x)).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.

]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerMethodLastStatementTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.
aMethod addStatement: (Int new).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new)equals: expectedType.



]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerMethodReturnTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.
aMethod addStatement: (Rtrn exp: (Int new)).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: nil)equals: expectedType.



]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerVariableMethodWithImplicitReturnTyping [

| aMethod expectedType |
aMethod := Mthd new.
aMethod selector: #number.
aMethod addStatement: (Asn varname: #x expression: (Int new)).

expectedType := TArrow type: (TVar newvar)  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.



]