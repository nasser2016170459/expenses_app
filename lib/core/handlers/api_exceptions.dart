abstract class ApiException {}

class ForbiddenException extends ApiException {}

class UnauthorizedException extends ApiException {}

class BadRequestException extends ApiException {}

class NotFoundException extends ApiException {}

class TimeoutException extends ApiException {}

class UnknownException extends ApiException {}

class ServerErrorException extends ApiException {}

class ConflictException extends ApiException {}

class PayloadTooLargeException extends ApiException {}

class GoneException extends ApiException {}
