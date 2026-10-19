package org.anaos.updater

/** AnaOS build numbers are YYYYMMDDNN — lexicographic order matches chronology. */
object BuildNumber {
    fun compare(a: String, b: String): Int = a.compareTo(b)

    fun isAtLeast(current: String, minimum: String): Boolean = compare(current, minimum) >= 0

    /** True if [candidate] is a strict upgrade over [current]. */
    fun isNewer(candidate: String, current: String): Boolean = compare(candidate, current) > 0
}
