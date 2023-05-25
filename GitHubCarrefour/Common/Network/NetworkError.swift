import Foundation

public enum NetworkError: Error, Equatable {
    case badURL(String)
    case serverError(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(String)
    case invalidResponse(String)
    case connectionError(String)
    
    var errorDescription: String {
        switch self {
        case .connectionError(_):
            return "Voce está sem internet, conecte e tente novamente"
        default:
            return "Ocorreu um erro em sua solicitação"
        }
    }
}
