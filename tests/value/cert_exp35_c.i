/* run.config*
   STDOPT:
*/

/* These declarations are useful for the plugin 'variadic' */
//@ axiomatic String { predicate valid_read_string{L}(char *s); }
struct __fc_FILE {
  unsigned int __fc_FILE_id;
  unsigned int __fc_FILE_data;
};
typedef struct __fc_FILE FILE;
extern FILE * __fc_stdout;
//@ assigns \result, __fc_stdout->__fc_FILE_data;
int printf(const char * restrict format, ...);

struct X { char a[6]; };

struct X addressee(void) {
  struct X result = { "world" };
  return result;
}

int main(void) {
  printf("Hello, %s!\n", addressee().a);
  return 0;
}

/*
From https://www.securecoding.cert.org/confluence/display/seccode/EXP35-C.+Do+not+access+or+modify+an+array+in+the+result+of+a+function+call+after+a+subsequent+sequence+point
 
This solution is problematic because of three inherent properties of C:

In C, the lifetime of a return value ends at the next sequence point. 
Consequently by the time printf() is called, the struct returned by 
the addressee() call is no longer considered valid, and may have been 
overwritten.
C function arguments are passed by value. As a result, copies are made 
of all objects generated by the arguments. For example, a copy is made of the 
pointer to "Hello, %s!\n". Under most circumstances, these copies protect you 
from the effects of sequence points described earlier.
Finally, C implicitly converts arrays to pointers when passing them as 
function arguments. This means that a copy is made of the pointer to the 
addresee().a array, and that pointer copy is passed to printf(). 
But the array data itself is not copied, and may no longer exist when printf()
is called.
Consequently when printf() tries to dereference the pointer passed as 
its 2nd argument, it is likely to find garbage.

*/
