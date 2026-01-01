//
//  Debugger.swift
//  Truman
//
//  Created by Moyses Azevedo on 28/12/25.
//

import Foundation

public enum Debugger {

    // MARK: - Public API

    public static func client(
        endPoint: String,
        method: String,
        header: [String: String],
        parameters: [String: Any]
    ) {
        log {
            banner("CLIENT")
            print("► Method: \(method)")
            print("► Endpoint: \(endPoint)\n")
            printStringKeyValueBlock(title: "Headers", header)
            printStringKeyValueBlock(title: "Parameters", parameters)
            footer()
        }
    }

    public static func server(
        header: [AnyHashable: Any],
        statusCode: Int,
        response: Any
    ) {
        log {
            banner("SERVER")
            printKeyValueBlock(title: "Headers", header)
            print("► StatusCode: \(statusCode)")
            print("► Response:")
            print(response)
            footer()
        }
    }

    public static func serverJSON(
        data: Data,
        header: [AnyHashable: Any],
        statusCode: Int
    ) {
        log {
            banner("SERVER (JSON)")
            printKeyValueBlock(title: "Headers", header)
            print("► StatusCode: \(statusCode)\n")
            print("► JSON Response:")
            print(prettyJSON(data))
            footer()
        }
    }
}

//#if DEBUG

private extension Debugger {

    static func log(_ block: () -> Void) {
        block()
    }

    static func banner(_ title: String) {
        print("\n==================== \(title.uppercased()) ====================\n")
    }

    static func footer() {
        print("\n===========================================================\n")
    }

    static func printKeyValueBlock(
        title: String,
        _ dict: [AnyHashable: Any]
    ) {
        print("► \(title):")

        let maxKey = dict.keys.map { "\($0)".count }.max() ?? 0
        for (key, value) in dict {
            let padded = "\(key)".padding(
                toLength: maxKey,
                withPad: " ",
                startingAt: 0
            )
            print("   ▪︎ \(padded) : \(value)")
        }
        print("")
    }

    static func printStringKeyValueBlock(
        title: String,
        _ dict: [String: Any]
    ) {
        print("► \(title):")

        let maxKey = dict.keys.map { $0.count }.max() ?? 0
        for (key, value) in dict {
            let padded = key.padding(
                toLength: maxKey,
                withPad: " ",
                startingAt: 0
            )
            print("   ▪︎ \(padded) : \(value)")
        }
        print("")
    }

    static func prettyJSON(_ data: Data) -> String {
        guard
            let obj = try? JSONSerialization.jsonObject(with: data),
            let pretty = try? JSONSerialization.data(
                withJSONObject: obj,
                options: [.prettyPrinted]
            ),
            let string = String(data: pretty, encoding: .utf8)
        else {
            return "❌ Failed to decode JSON"
        }

        return string
    }
}

//#else
//
//// MARK: - Release no-op
//
//private extension Debugger {
//    static func log(_ block: () -> Void) {}
//}

//#endif
