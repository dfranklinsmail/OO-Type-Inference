Class {
	#name : #Obj,
	#superclass : #Exp,
	#instVars : [
		'class'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #'as yet unclassified' }
Obj class >> instantiate: aCls [
	^ self new class: aCls.
]

{ #category : #'as yet unclassified' }
Obj >> class: cls [
	class := cls.
]

{ #category : #'as yet unclassified' }
Obj >> send: method [
	class addMethod: method.
]

{ #category : #'as yet unclassified' }
Obj >> typeOf: environment [
	^ TObj from: (class typeOf: environment).
]
