
CREATE TYPE sexoUsuario AS Enum('Masculino','Feminino','Não Informado');
CREATE TYPE tipoUsuario AS Enum('Professor','Aluno','Funcionario');

create table endereco(
                         cep varchar(10),
                         rua varchar(60),
                         cidade varchar(20),
                         estado char(3),
                         constraint pk_endereco primary key (cep)
);


CREATE TABLE Usuario(
                        nome varchar(30),
                        sobrenome varchar(30),
                        telefone char (15),
                        email char(30),
                        sexo sexoUsuario,
                        senha char(20),
                        cep char(10),
                        numero integer,
                        tipo tipoUsuario,
                        CONSTRAINT PK_usuario PRIMARY KEY (nome, sobrenome,telefone),
                        CONSTRAINT UQ_usuario UNIQUE(email),
                        constraint fk_user_end foreign key(cep)
                            references endereco (cep)
                            ON DELETE CASCADE ON UPDATE cascade

);



CREATE TABLE Funcionario(
                            nome varchar(30),
                            sobrenome varchar(30),
                            telefone char(15),
                            Cardo varchar(20),
                            CONSTRAINT PK_Funcionario PRIMARY KEY (nome, sobrenome,telefone),
                            CONSTRAINT FK_func_user FOREIGN KEY (nome,sobrenome,telefone)
                                REFERENCES Usuario (nome,sobrenome,telefone)
                                ON DELETE CASCADE ON UPDATE cascade
);


create table unidade(
                        codigo varchar(5),
                        cidade varchar(20),
                        estado char(3),
                        pais varchar(10),
                        predio varchar(20),
                        bloco varchar(5),
                        constraint PK_unidade primary key (codigo)
);



create table Professor(
                          nome varchar(30),
                          sobrenome varchar(30),
                          telefone char(15),
                          especializacao varchar(10),
                          titulacao varchar(10),
                          codigoUnidade varchar(5),
                          constraint pk_professor primary key (nome,sobrenome,telefone),
                          constraint fk_prof_unidade foreign key (codigoUnidade)
                              references unidade(codigo)
                              ON DELETE CASCADE ON UPDATE cascade

);

create table aluno(
                      nome varchar(30),
                      sobrenome varchar(30),
                      telefone char(15),
                      codigoUnidade varchar(5),
                      constraint pk_aluno primary key (nome,sobrenome,telefone),
                      constraint fk_aluno_unidade foreign key (codigoUnidade)
                          references unidade(codigo)
                          ON DELETE CASCADE ON UPDATE cascade

);

create type tipoComunicado as Enum('Mensagem','Aviso');

create table comunicado(
                           codigo varchar(5),
                           tipo tipoComunicado,
                           texto varchar(100),
                           DataEnvio timestamp,
                           constraint pk_comunicado primary key (codigo)
);

create table aviso(
                      codigoComunicado varchar(5),
                      nome varchar(30),
                      sobrenome varchar(30),
                      telefone char(15),
                      constraint fk_aviso_comunicado foreign key (codigoComunicado)
                          references comunicado (codigo)
                          ON DELETE CASCADE ON UPDATE cascade,
                      constraint pk_aviso primary key (codigoComunicado,nome,sobrenome,telefone),
                      constraint fk_aviso_funcionario foreign key (nome,sobrenome,telefone)
                          references Funcionario (nome,sobrenome,telefone)
);

create table mensagem(
                         codigoComunicado varchar(5),
                         nome varchar(30),
                         sobrenome varchar(30),
                         telefone char(15),
                         constraint fk_mensagem_comunic foreign key (codigoComunicado)
                             references comunicado (codigo)
                             ON DELETE CASCADE ON UPDATE cascade,
                         constraint fk_mensagem_prof foreign key (nome,sobrenome,telefone)
                             references Professor (nome,sobrenome,telefone),
                         constraint pk_mensagem primary key (codigoComunicado,nome,sobrenome,telefone)
);

create table recebe(
                       codigoComunicado varchar(5),
                       nomeAluno varchar(30),
                       sobrenomeAluno varchar(30),
                       telefoneAluno char(15),
                       constraint pk_recebe primary key (codigoComunicado,nomeAluno,sobrenomeAluno,telefoneAluno),
                       constraint fk_recebe_comunicado foreign key(codigoComunicado)
                           references comunicado (codigo)
                           ON DELETE CASCADE ON UPDATE cascade,
                       constraint fk_recebe_aluno foreign key(nomeAluno,sobrenomeAluno,telefoneAluno)
                           references aluno (nome,sobrenome,telefone)
                           ON DELETE CASCADE ON UPDATE cascade
);


create table disciplina(
                           codigo varchar(10),
                           nome varchar(30),
                           aulasSemanais smallint,
                           materialRecomendado varchar(50),
                           codigoUnidade varchar(5),
                           constraint pk_disciplina primary key (codigo),
                           constraint fk_disci_unidade foreign key (codigoUnidade)
                               references unidade (codigo)
                               ON DELETE CASCADE ON UPDATE cascade,
                           constraint uq_disciplina unique (nome)
);


create table ministra(
                         nomeProfessor varchar(30),
                         sobrenomeProfessor varchar(30),
                         telefoneProfessor varchar(15),
                         codigoDisciplina varchar(10),
                         semestreLetivo char(20),
                         constraint pk_ministra primary key (nomeProfessor,sobrenomeProfessor,telefoneProfessor,codigoDisciplina),
                         constraint uq_minitra unique(semestreLetivo),
                         constraint fk_ministra_prof foreign key (nomeProfessor,sobrenomeProfessor,telefoneProfessor)
                             references Professor(nome,sobrenome,telefone)
                             ON DELETE CASCADE ON UPDATE cascade,
                         constraint fk_ministra_disciplina foreign key(codigoDisciplina)
                             references disciplina (codigo)
                             on delete cascade on update cascade
);
create table avalia(
                       nomeProfessor varchar(30),
                       sobrenomeProfessor varchar(30),
                       telefoneProfessor varchar(15),
                       nomeAluno varchar(30),
                       sobrenomeAluno varchar(30),
                       telefoneAluno varchar(15),
                       codigoDisciplina varchar(10),
                       texto varchar(100),
                       notaDidatica smallint,
                       notaMaterial smallint,
                       notaRelevancia smallint,
                       notaInfra smallint,
                       constraint pk_avalia primary key (nomeProfessor,sobrenomeProfessor,telefoneProfessor,nomeAluno,sobrenomeAluno,telefoneAluno,codigoDisciplina),
                       constraint fk_avalia_ministra foreign key(nomeProfessor,sobrenomeProfessor,telefoneProfessor,codigoDisciplina)
                           references ministra(nomeProfessor,sobrenomeProfessor,telefoneProfessor,codigoDisciplina)
                           on delete cascade on update cascade,
                       constraint fk_avalia_aluno foreign key (nomeAluno,sobrenomeAluno,telefoneAluno)
                           references Aluno(nome,sobrenome,telefone)
                           on delete cascade on update cascade

);


create type statusMatricula as enum('ativa', 'trancada', 'concluída', 'reprovada');
create table matricula(
                          nomeAluno varchar(30),
                          sobrenomeAluno varchar(30),
                          telefoneAluno varchar(15),
                          codigoDisciplina varchar(10),
                          periodoLetivo varchar(5),
                          dataEfetivacao timestamp,
                          status statusMatricula,
                          notaFinal smallint,
                          bolsaDeEstudos bool,
                          DescontoAplicado smallint,
                          valorDePagamento int,

                          constraint pk_matricula primary key (nomeAluno,sobrenomeAluno,telefoneAluno, codigoDisciplina, periodoLetivo),
                          constraint fk_matricula_aluno foreign key(nomeAluno,sobrenomeAluno,telefoneAluno)
                              references aluno(nome,sobrenome,telefone)
                              on delete cascade on update cascade,
                          constraint fk_matricula_disciplina foreign key(codigoDisciplina)
                              references disciplina(codigo)
                              on delete cascade on update cascade
);



create table departamento(
                             codigo varchar(10),
                             nome varchar(20),
                             nomeProfessor varchar(30),
                             sobrenomeProfessor varchar(30),
                             telefoneProfessor varchar(15),
                             constraint uq_departamento unique (nome),
                             constraint fk_departamento_professor foreign key(nomeProfessor,sobrenomeProfessor,telefoneProfessor)
                                 references professor(nome,sobrenome,telefone)
                                 on delete cascade on update cascade,
                             constraint pk_departamento primary key (codigo)
);
create table curso(
                      codigo varchar(10),
                      nome varchar(20),
                      nivel integer,
                      cargaHoraria integer,
                      vagas int,
                      salaDeAula varchar(10),
                      Ementa varchar(50),
                      codigoDepartamento varchar(10),
                      codigoUnidade varchar(10),
                      constraint fk_curso_depart foreign key (codigoDepartamento)
                          references departamento (codigo)
                          on delete cascade on update cascade,
                      constraint fk_curso_unidade foreign key(codigoUnidade)
                          references unidade(codigo)
                          on delete cascade on update cascade,
                      constraint uq_curso unique(nome),
                      constraint pk_curso primary key (codigo)
);
create table regras(
                       codigoCurso varchar(10),
                       regra varchar(30),

                       constraint pk_regras primary key (codigoCurso, regra),
                       constraint fk_regras_curso foreign key(codigoCurso)
                           references curso(codigo)
                           on delete cascade on update cascade
);

create table NecessidadesDeInfraestrutura(
                                             codigoCurso varchar(10),
                                             necessidadeDeInfraestrutura varchar(30),
                                             CONSTRAINT fk_necessi_curso FOREIGN KEY (codigoCurso)
                                                 REFERENCES curso(codigo)
                                                 on delete cascade on update cascade,
                                             constraint pk_necessidades primary key(codigoCurso,necessidadeDeInfraestrutura)

);

create table Compoe(
                       codigoCurso varchar(10),
                       codigoDisciplina varchar(10),
                       constraint pk_compoe primary key(codigoCurso,codigoDisciplina),
                       constraint fk_compoe_curso foreign key (codigoCurso)
                           references curso(codigo)
                           on delete cascade on update cascade,
                       constraint fk_compoe_disciplina foreign key(codigoDisciplina)
                           references disciplina(codigo)
                           on delete cascade on update cascade
);

create table PreRequisitoCursoeCurso(
                                        codigoCurso varchar(10),
                                        codigoCurso2 varchar(10),
                                        constraint pk_PreRequisitoCursoeCurso primary key(codigoCurso,codigoCurso2),
                                        constraint fk_preReqCurCur_curso foreign key (codigoCurso)
                                            references curso(codigo)
                                            on delete cascade on update cascade,
                                        constraint fk_preReqCurCur2_curso foreign key (codigoCurso2)
                                            references curso(codigo)
                                            on delete cascade on update cascade

);
create table PreRequisitoCursoeDisciplina(
                                             codigoCurso varchar(10),
                                             codigoDisciplina varchar(10),
                                             constraint pk_PreRequisitoCursoeDisciplina primary key(codigoCurso,codigoDisciplina),
                                             constraint fk_preReqCurDisc_disciplina foreign key(codigoDisciplina)
                                                 references disciplina(codigo)
                                                 on delete cascade on update cascade,
                                             constraint fk_preReqCurDisc_curso foreign key(codigoCurso)
                                                 references curso(codigo)
                                                 on delete cascade on update cascade
);