
import Foundation

func fetchData(from urlString: String, completion: @escaping(SuperHero?, Error?) -> Void) {
    guard let url = URL(string: urlString) else {
        print("Ошибка с URL: \(urlString)")
        return
    }
    
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Ошибка запроса: \(error.localizedDescription)")
            completion(nil, error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Ошибка: Неверный ответ от сервера")
            completion(nil, NSError(domain: "Invalid Response", code: -1, userInfo: nil))
            return
        }
        
        switch httpResponse.statusCode {
        case 200:
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(SuperHero.self, from: data)
                    completion(result, nil)
                } catch {
                    print("Ошибка декодирования данных: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
        case 404:
            print("Ошибка 404: Страница не найдена")
            completion(nil, NSError(domain: "Not Found", code: 404, userInfo: nil))
        case 500:
            print("Ошибка 500: Внутренняя ошибка сервера")
            completion(nil, NSError(domain: "Server Error", code: 500, userInfo: nil))
        default:
            print("Неизвестная ошибка с кодом: \(httpResponse.statusCode)")
            completion(nil, NSError(domain: "Unexpected Error", code: httpResponse.statusCode, userInfo: nil))
        }
    }
    
    task.resume()
}
