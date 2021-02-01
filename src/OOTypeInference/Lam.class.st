Class {
	#name : #Lam,
	#superclass : #Exp,
	#instVars : [
		'varname',
		'exp'
	],
	#category : #OOTypeInference
}

{ #category : #'instance creation' }
Lam class >> varname: aString exp: exp [ 
	^ self new varname: aString exp: exp
]

{ #category : #printing }
Lam >> printOn: aStream [
	aStream nextPutAll: 'fun ';nextPutAll: varname;nextPutAll: ' -> '.
	exp printOn: aStream.

	
]

{ #category : #'type inference' }
Lam >> typeOf: env [
"Lam (x,e) -> 
           let ty_x = newvar () in
           let ty_e = typeof ((x,ty_x)::env) e in
           TArrow(ty_x,ty_e)"
	| typX typE |
	typX := self newvar.
	typE := exp typeOf: (varname arrow: typX prependTo: env).
	^ TArrow type: typX arrow: typE
]

{ #category : #accessing }
Lam >> varname: aString exp: aToyVar [ 
	exp := aToyVar.
	varname := aString.

]
