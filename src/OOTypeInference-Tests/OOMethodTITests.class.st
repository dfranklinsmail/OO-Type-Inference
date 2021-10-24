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

| aMethod expectedType args |
aMethod := Mthd new.
aMethod selector: #number.

aMethod addArgument: (Asn varname: #y expression: (Int new)).

aMethod addStatement: (Asn varname: #x expression: (Int new)).
aMethod addStatement: (Rtrn exp: (Var varname: #x)).

args := OrderedCollection new.
args add: (TCls class: (Int class)).
expectedType := TArrow type: args  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.


]

{ #category : #tests }
OOMethodTITests >> testSameMethod1 [
	| m1 expectedType a1 a2 arguments |
	"test that ('a -> 'b) -> ('a -> 'b) is not the same as ('b -> 'a) -> ('a -> 'b)"
	a1 := Int new.
	a2 := Int new.
	
	m1 := Mthd new.
	m1 addArgument: a1.
	m1 addStatement: a2.
	
	expectedType := m1 typeOf: Dictionary new.  
	
	arguments := OrderedCollection new.
	arguments add: (TCls class: (Int class)).
	
	self assert: (TArrow type: arguments arrow: (TCls class: (Int class))) equals: expectedType.

]

{ #category : #tests }
OOMethodTITests >> testSelectorsDontMatch [

| m1 m2 |
m1 := Mthd new.
m1 selector: #number.

m2 := Mthd new.
m2 selector: #string.

self assert: (m1 typeOf: Dictionary new) equals: (m2 typeOf: Dictionary new).



]

{ #category : #tests }
OOMethodTITests >> testSelectorsMatch [

| m1 m2 |
m1 := Mthd new.
m1 selector: #number.

m2 := Mthd new.
m2 selector: #number.

self assert: (m1 typeOf: Dictionary new) equals: (m2 typeOf: Dictionary new).



]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerMethodAssignAndReturnTyping [

| aMethod expectedType x args |
aMethod := Mthd new.
aMethod selector: #number.
x:= (Asn varname: #x expression: (Int new)).
aMethod addStatement: x.
aMethod addStatement: (Rtrn exp: (Var varname: #x)).

args := OrderedCollection new.
expectedType := TArrow type: args arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.

]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerMethodLastStatementTyping [

| aMethod expectedType args |
aMethod := Mthd new.
aMethod selector: #number.
aMethod addStatement: (Int new).

args := OrderedCollection new.
expectedType := TArrow type: args  arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new)equals: expectedType.



]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerMethodReturnTyping [

| aMethod expectedType args |
aMethod := Mthd new.
aMethod selector: #number.
aMethod addStatement: (Rtrn exp: (Int new)).

args := OrderedCollection new.
expectedType := TArrow type: args arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: nil)equals: expectedType.



]

{ #category : #tests }
OOMethodTITests >> testSmallIntegerVariableMethodWithImplicitReturnTyping [

| aMethod expectedType args |
aMethod := Mthd new.
aMethod selector: #number.
aMethod addStatement: (Asn varname: #x expression: (Int new)).

args := OrderedCollection new.
expectedType := TArrow type: args arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.



]
