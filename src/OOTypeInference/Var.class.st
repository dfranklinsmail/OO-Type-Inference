Class {
	#name : #Var,
	#superclass : #Exp,
	#instVars : [
		'varname'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #'instance creation' }
Var class >> varname: aString [ 
	^ self new varname: aString
]

{ #category : #'as yet unclassified' }
Var >> inst: env [ 
   "The function inst instantiates a type schema, that is, replaces each QVar with a fresh TVar"

]

{ #category : #printing }
Var >> printOn: aStream [
	aStream nextPut: $'.
	aStream nextPutAll: varname.

]

{ #category : #'as yet unclassified' }
Var >> typeOf: env [ 
   (env includesKey: varname) ifTrue: [ ^ env at: varname ].
   ^ self newvar.
]

{ #category : #accessing }
Var >> varname: aString [ 
	varname := aString
]
