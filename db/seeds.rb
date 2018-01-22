Question.delete_all

Question.create(pillar: '1', name:'SprintNoEsUnaCascada', description: 'Las Historias se implementan a través de múltiples ciclos de desarrollo-pruebas, el sprint no es una cascada.')
Question.create(pillar: '1', name:'TresAmigos', description: 'Trabajo en parejas o grupos con diferentes roles es parte natural del día a día. Existe una conversación y colaboración activa entre los desarrolladores, testers y PO.')
Question.create(pillar: '1', name:'ParticiparDesdeElInicio', description: 'Los desarrolladores y testers participan desde la definición o refinamiento de las historias o requerimientos de negocio.')
Question.create(pillar: '1', name:'TodosHacenTesting', description: 'Todo el equipo contribuye con actividades de testing (ejm: los desarrolladores ejecutan un conjunto de casos de pruebas funcionales en su ambiente; los desarrolladores automatizan pruebas).')
Question.create(pillar: '1', name:'TodosSonResponsables', description: 'Tanto desarrolladores como testers se consideran un solo equipo. Cualquier retraso o problema es responsabilidad de todos.')

Question.create(pillar: '2', name:'PiramidePruebas', description: 'Se utiliza una estrategia basada en la Pirámide de Automatización, y se crean pruebas a nivel unitario, integración y de UI.')
Question.create(pillar: '2', name:'NoSeNecesitaTareasManuales', description: 'Las tareas de configuración de la prueba (ejm: generación de data) y cierre de la prueba (ejm: generar reportes, guardar evidencia) se encuentran automatizados. No son necesarias tareas manuales para ejecutar cualquier prueba automatizada.')
Question.create(pillar: '2', name:'EjecutanContinuamente', description: 'Las pruebas automatizadas se ejecutan continuamente, una significativa ejecución se realiza al menos 1 vez al día. La ejecución de todas las pruebas se encuentra integrada en el proceso de CI/CD.')
Question.create(pillar: '2', name:'ResultadosTransparentes', description: 'Los resultados de las pruebas automatizadas son altamente visibles y accesibles, el equipo monitorea estos resultados y toma inmediata acción cuando alguna prueba falla.')

Question.create(pillar: '3', name:'RiskBasedTesting', description: 'Risk Based Testing es utilizado para reducir inteligentemente el alcance de las pruebas a realizar.')
Question.create(pillar: '3', name:'ExploratoryTesting', description: 'Sesiones de Exploratory Testing son parte regular del trabajo durante el sprint. Se promueve este trabajo en parejas y se realizan discusiones grupales sobre los resultados encontrados.')
Question.create(pillar: '3', name:'DisenoPruebaIterativo', description: 'Estrategia, planificación y diseño de la prueba se realiza de manera iterativa a nivel release, sprint e historia. En cada ocasión se refinan las ideas anteriores y se utilizan formatos ligeros que comuniquen eficientemente las ideas y sean fáciles de mantener.')
Question.create(pillar: '3', name:'BalancePruebas', description: 'Las pruebas están balanceadas a nivel manual, automatizado y exploratorio, incluyendo pruebas no funcionales. El balance lo determina el propio equipo.')
Question.create(pillar: '3', name:'EstandaresConsistentes', description: 'A nivel de testing, se tiene estándares, templates y checklist consistentes que son usados por todo el equipo. Se tiene un repositorio que permite la transparencia de todo los artefactos.')
Question.create(pillar: '3', name:'FeedbackEsPorMejoras', description: 'El feedback de los usuarios sobre el producto es sobre mejoras y no por fallos graves.')

AssessmentTotals.create(respondents_number: 0)