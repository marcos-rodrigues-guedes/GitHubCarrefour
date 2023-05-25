import SwiftUI

struct DetalisView: View {
    
    @ObservedObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        ZStack (alignment: .top) {
            if case UsersDetailsUIState.loading = viewModel.uiState {
                ProgressView("Carregando")
            } else if case UsersDetailsUIState.error(let msg) = viewModel.uiState {
                AlertErrorView(action: { viewModel.onAppear() }, msg: msg)
            } else if case UsersDetailsUIState.success = viewModel.uiState {
                detailsView
            } else {
                AlertErrorView(action: { viewModel.onAppear() }, msg: "Erro desconhecido")
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension DetalisView {
    var detailsView: some View {
        return VStack {
            Form {
                Section(header: Text("Perfil")) {
                    HStack{
                        ImageView(url: viewModel.userDetails?.avatarUrl ?? String(),
                                  width: 60,
                                  height: 60)
                        VStack(alignment: .leading) {
                            Text(viewModel.userDetails?.login ?? String())
                                .font(.title)
                                .italic(true)
                                .padding(.bottom, 3)
                                .bold()
                            
                            Text(viewModel.userDetails?.name ?? String())
                                .font(.body)
                                .padding(.bottom, 3)
                            HStack {
                                Text("followers")
                                Text(viewModel.userDetails?.followers ?? String())
                            }
                            HStack {
                                Text("following")
                                Text(viewModel.userDetails?.following ?? String())
                            }
                            
                        }
                        .padding()
                        .cornerRadius(20)
                        
                        
                    }
                    HStack {
                        Text("local")
                            .font(.body)
                        Spacer()
                        Text(viewModel.userDetails?.location ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("e-mail")
                        Spacer()
                        Text(viewModel.userDetails?.email ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("blog")
                        Spacer()
                        Text(viewModel.userDetails?.blog ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("twitter")
                        Spacer()
                        Text(viewModel.userDetails?.twitter ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Empresa")
                        Spacer()
                        Text(viewModel.userDetails?.company ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Criado")
                        Spacer()
                        Text(viewModel.userDetails?.created ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Atualizado")
                        Spacer()
                        Text(viewModel.userDetails?.updated ?? String())
                            .disabled(true)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("repositórios públicos")
                        Spacer()
                        Text(viewModel.userDetails?.publicResp ?? String())
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    LoadingButtonView(action: {
                        viewModel.showRepos()
                    }, text: "Repositórios",
                       showProgress: viewModel.showingProgress)
                }
            }
            .sheet(isPresented: $viewModel.showingRepo) {
                UserRepositoriesListView(listRepositories: viewModel.userRepositories)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }.alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("Ops! Não foi possivel buscar os repositórios, verifique sua rede"),
                message: Text("Tentar novamente?"),
                primaryButton: .default(Text("Sim")) {
                    viewModel.showRepos()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
