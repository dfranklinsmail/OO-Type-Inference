Class {
	#name : #Char,
	#superclass : #Exp,
	#instVars : [
		'varname'
	],
	#category : #'OOTypeInference-LanguageValues'
}

{ #category : #accessing }
Char >> typeOf: environment [
	^TCls class: self.
]
