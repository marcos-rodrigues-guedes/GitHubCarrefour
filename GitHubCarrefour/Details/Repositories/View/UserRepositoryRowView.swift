import Foundation
import SwiftUI

struct UserRepositoryRowView: View {
    
    let viewModel: UserRepositoryRowViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Image("gitHubIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Text(viewModel.fullName)
                        .font(.body)
                        .padding(.bottom, 1)
                        .multilineTextAlignment(.leading)
                        .bold()
                        
                    
                    Text(viewModel.description)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .padding(1)
                    HStack {
                        Text("Criado")
                        Text(viewModel.created)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Atualizado")
                        Text(viewModel.updated)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }

                }
                Spacer()
            }
        }
    }
}

struct UserRepositoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
          VStack {
              UserRepositoryRowView(viewModel:
                                      UserRepositoryRowViewModel(
                                        id: 0,
                                        name: "30daysoflaptops.github.io",
                                          fullName: "mojombo/30daysoflaptops.github.io",
                                          description: "Destroy your Atom editor, Asteroids style!",
                                          visibility: "Public",
                                          created: "10/03/2023",
                                          updated: "10/02/2023"))
          }.padding()
                .frame(maxWidth: .infinity, maxHeight: 200)
          .previewDevice("iPhone 11")
          .preferredColorScheme($0)
        }
    }
}
