class MangaTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testLinkCodec() {
      String test = '#!a b\tc#d+e!fz09#!$%^&()';
      assertEquals  "a_b_c_d_e_fz09", test.encodeAsLink()
    }
}
