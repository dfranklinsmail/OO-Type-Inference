Class {
	#name : #Let,
	#superclass : #Exp,
	#instVars : [
		'varname',
		'exp1',
		'exp2'
	],
	#category : #OOTypeInference
}

{ #category : #'instance creation' }
Let class >> varname: aString exp: exp1 exp: exp2 [ 
	^ self new varname: aString exp: exp1 exp: exp2
]

{ #category : #printing }
Let >> printOn: aStream [
	aStream nextPutAll: 'let '.
	varname printOn: aStream.
	aStream nextPutAll: ' = '.
	exp1 printOn: aStream.
	aStream nextPutAll: ' in '.
	exp2 printOn: aStream.

]

{ #category : #'type inference' }
Let >> typeOf: env [
	"Let (x,e,e2) -> 
           let ty_e = typeof env e in
           typeof ((x,gen ty_e)::env) e2"
	| typE |
	typE := exp1 typeOf: env.
	^ exp2 typeOf: (varname arrow: (typE gen) prependTo: env).

]

{ #category : #accessing }
Let >> varname: aString exp: anExp1 exp: anExp2 [ 
	varname := aString.
	exp1 := anExp1.
	exp2 := anExp2.

]
