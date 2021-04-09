//
//  CharactersInjector.swift
//  Injector
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Data
import Domain
import Foundation

public class ChractersInjector {
    public static func provideCharactersUseCase() -> CharactersUseCaseContract {
        return CharactersUseCase(provider: CharactersProvider())
    }
    
    public static func provideCharacterDetailUseCase() -> CharacterDetailUseCaseContract {
        return CharacterDetailUseCase(provider: CharacterDetailProvider())
    }
}
