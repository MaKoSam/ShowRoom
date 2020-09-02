//MARK: - Logger package

handlers = java.util.logging.FileHandler, java.util.logging.ConsoleHandler

java.util.logging.FileHandler.level     = INFO
java.util.logging.FileHandler.formatter = java.util.logging.SimpleFormatter
java.util.logging.FileHandler.append    = true
java.util.logging.FileHandler.pattern   = log.%u.%g.txt

java.util.logging.ConsoleHandler.level     = INFO
java.util.logging.ConsoleHandler.formatter = java.util.logging.SimpleFormatter
