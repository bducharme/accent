defmodule LangueTest.Formatter.JavaPropertiesXml.Expectation do
  alias Langue.Entry

  defmodule Simple do
    use Langue.Expectation.Case

    def render do
      """
      <?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
      <properties>
        <!-- XML COMMENT -->
        <entry key="yes">Oui</entry>
        <entry key="url.hello">Bonjour</entry>
        <entry key="url.nested.ultra">I’m so nested</entry>
        <entry key="url.normal">Normal string</entry>
      </properties>
      """
    end

    def entries do
      [
        %Entry{key: "yes", value: "Oui", comment: "  <!-- XML COMMENT -->", index: 1},
        %Entry{key: "url.hello", value: "Bonjour", comment: "", index: 2},
        %Entry{key: "url.nested.ultra", value: "I’m so nested", comment: "", index: 3},
        %Entry{key: "url.normal", value: "Normal string", comment: "", index: 4}
      ]
    end
  end

  defmodule InterpolationValues do
    use Langue.Expectation.Case

    def render do
      """
      single=${const:java.awt.event.KeyEvent.VK_CANCEL}
      multiple=${single}, ${sys:user.home}/settings.xml
      duplicate=${env:JAVA_HOME}, ${env:JAVA_HOME}!
      empty=Hello, ${}.
      """

      """
      <?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
      <properties>
        <entry key="single">${const:java.awt.event.KeyEvent.VK_CANCEL}</entry>
        <entry key="multiple">${single}, ${sys:user.home}/settings.xml</entry>
        <entry key="duplicate">${env:JAVA_HOME}, ${env:JAVA_HOME}!</entry>
        <entry key="empty">Hello, ${}.</entry>
      </properties>
      """
    end

    def entries do
      [
        %Entry{index: 1, key: "single", value: "${const:java.awt.event.KeyEvent.VK_CANCEL}", comment: "", interpolations: ~w(${const:java.awt.event.KeyEvent.VK_CANCEL})},
        %Entry{index: 2, key: "multiple", value: "${single}, ${sys:user.home}/settings.xml", comment: "", interpolations: ~w(${single} ${sys:user.home})},
        %Entry{index: 3, key: "duplicate", value: "${env:JAVA_HOME}, ${env:JAVA_HOME}!", comment: "", interpolations: ~w(${env:JAVA_HOME} ${env:JAVA_HOME})},
        %Entry{index: 4, key: "empty", value: "Hello, ${}.", comment: "", interpolations: ~w(${})}
      ]
    end
  end
end
