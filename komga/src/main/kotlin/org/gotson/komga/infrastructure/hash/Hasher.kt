package org.gotson.komga.infrastructure.hash

import mu.KotlinLogging
import org.apache.commons.codec.digest.XXHash32
import org.springframework.stereotype.Component
import java.nio.file.Path
import kotlin.io.path.inputStream

private val logger = KotlinLogging.logger {}

private const val DEFAULT_BUFFER_SIZE = 4096
private const val SEED = 0

@Component
class Hasher {

  fun computeHash(path: Path): String {
    logger.info { "Hashing: $path" }
    val hash = XXHash32(SEED)

    path.inputStream().use {
      val buffer = ByteArray(DEFAULT_BUFFER_SIZE)
      var len: Int

      do {
        len = it.read(buffer)
        if (len >= 0) hash.update(buffer, 0, len)
      } while (len >= 0)
    }

    return hash.value.toString(36)
  }
}
