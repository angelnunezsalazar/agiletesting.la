require "selenium-webdriver"

describe "User in the Assessment Journey" do
    
    driver = nil
    root_url = "http://localhost:9292"

    it "Completes the Assessment" do
        driver.navigate.to root_url
        
        driver.find_element(id: 'email').send_keys "angel@gmail.com"
        driver.find_element(id: 'organization').send_keys "kleer"
        driver.find_element(id: 'industry')
              .find_element(:css,"option[value='agricultura']").click
        driver.find_element(id: 'country')
              .find_element(:css,"option[value='PE']").click
        driver.find_element(id: 'submit').click
        
        driver.find_element(css: "#SprintNoEsUnaCascada option[value='5']").click
        driver.find_element(css: "#TresAmigos option[value='5']").click
        driver.find_element(css: "#ParticiparDesdeElInicio option[value='5']").click
        driver.find_element(css: "#TodosHacenTesting option[value='5']").click
        driver.find_element(css: "#TodosSonResponsables option[value='5']").click
        driver.find_element(id: 'step-1-next').click

        wait = Selenium::WebDriver::Wait.new(timeout: 3)
        wait.until { driver.find_element(id: "step-2").displayed? }

        driver.find_element(css: "#PiramidePruebas option[value='5']").click
        driver.find_element(css: "#NoSeNecesitaTareasManuales option[value='5']").click
        driver.find_element(css: "#EjecutanContinuamente option[value='5']").click
        driver.find_element(css: "#ResultadosTransparentes option[value='5']").click
        driver.find_element(id: 'step-2-next').click

        wait = Selenium::WebDriver::Wait.new(timeout: 3)
        wait.until { driver.find_element(id: "step-3").displayed? }

        driver.find_element(css: "#RiskBasedTesting option[value='5']").click
        driver.find_element(css: "#ExploratoryTesting option[value='5']").click
        driver.find_element(css: "#DisenoPruebaIterativo option[value='5']").click
        driver.find_element(css: "#BalancePruebas option[value='5']").click
        driver.find_element(css: "#EstandaresConsistentes option[value='5']").click
        driver.find_element(css: "#FeedbackEsPorMejoras option[value='5']").click
        driver.find_element(id: 'step-3-next').click

        text = driver.find_element(tag_name: 'h2').text
        expect(text).to eq('Resultados del Assessment')
    end

    before(:each) do
        driver = Selenium::WebDriver.for :chrome
    end
    
    after(:each) do
        driver.quit
    end
end