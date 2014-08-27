package org.xtendroid.xtendroidtest.test

import android.content.Intent
import android.test.ActivityInstrumentationTestCase2
import android.util.SparseBooleanArray
import org.json.JSONArray
import org.json.JSONObject
import org.xtendroid.xtendroidtest.activities.MainActivity
import org.xtendroid.xtendroidtest.parcel.ModelRoot
import android.os.Parcelable
import android.test.UiThreadTest
import static android.test.MoreAsserts.*

class ActivityParcelableAnnotationTest extends ActivityInstrumentationTestCase2<MainActivity> {
	
	var delay = 2000
	
	new() {
		super(MainActivity)
	}
	
    val jsonRaw = '''
	{
		  "a_str" : "String"
		, "c_double" : 1.1234
		, "d_int" : 1234
		, "e_long" : 123412341234
		, "f_string_array" : [ "head", "tail" ]
		, "g_boolean_array" : [ true, false, true ] 
		, "i_double_array" : [ 1.0e-2, 0.01, -1.0e-2 ] 
		, "k_int_array" : [ 1,2,3,4,5 ]
		, "l_long_array" : [ 1,2,3,4,5 ]
		, "f_string_list" : [ "head", "tail" ]
		, "n_bool" : true
		, "o_bool_array" : [ true, false, true ]
		, "p_date" : "2011-11-11T12:34:56.789Z"
		, "q_date_array" : [ "2011-11-11T12:34:56.789Z" ]
		, "submodel" : { "a" : true }
		, "lotsaSubmodels" : [ { "a" : true } ]
		, "evenMore" : [ { "a" : true } ]
	}
	'''
	
	val label = "org.xtendroid.xtendroidtest.test.payload"
	protected override setUp()
	{
		super.setUp
        val newIntent = new Intent()
		
        val model = new ModelRoot(new JSONObject(jsonRaw.toString))
        model.b_byte = "ä".bytes.get(0)
        model.c_float = 1.0f
        model.h_byte_array = "äöëü".bytes
        model.j_float_array = #[ 1.0f, 2.0f, 3.0f ]
        val sba = new SparseBooleanArray()
        sba.put(0,false)
        sba.put(1,true)
        sba.put(2,false)
        model.m_bool_array = sba
        model.r_json_array = new JSONArray('[false,true,false]');
	    newIntent.putExtra(label, model as Parcelable)
	    activityInitialTouchMode = false
		activityIntent = newIntent
	}
	
	@UiThreadTest
	def testAndroidParcelableAnnotation() {
		assertTrue(activity.intent.extras.containsKey(label))
		val model = activity.intent.extras.getParcelable(label) as ModelRoot
		val compareModel = new ModelRoot(new JSONObject(jsonRaw))
		assertEquals(model.b_byte, "ä".bytes.get(0))
		assertEquals(model.c_float, 1.0f)
		for (var i=0; i<4; i++)
			assertEquals(model.h_byte_array.get(i), "äöëü".bytes.get(i))
		for (var i=0; i<3; i++)			
			assertEquals(model.j_float_array.get(i), #[ 1.0f, 2.0f, 3.0f ].get(i))
		assertEquals(model.m_bool_array.get(1), true)
		
		// TODO fix below
//		for (var i=0; i<3; i++)
//			assertEquals(model.r_json_array.get(i), new JSONArray('[false,true,false]').get(i));
		
		// from @JsonProperty
//		assertEquals(model.astr, compareModel.astr) // TODO fix
//		assertEquals(model.b_byte, compareModel.b_byte)
//		assertEquals(model.cdouble, compareModel.cdouble)
//		assertEquals(model.c_float, compareModel.c_float) // TODO fix
//		assertEquals(model.dint, compareModel.dint) // TODO fix
//		assertEquals(model.elong, compareModel.elong) // TODO fix
//		assertEquals(model.fstringarray, compareModel.fstringarray) // TODO fix
//		assertEquals(model.gbooleanarray, compareModel.gbooleanarray)
//		assertEquals(model.h_byte_array, compareModel.h_byte_array)
//		assertEquals(model.idoublearray, compareModel.idoublearray)
//		assertEquals(model.j_float_array, compareModel.j_float_array)
//		assertEquals(model.kintarray, compareModel.kintarray)
//		assertEquals(model.llongarray, compareModel.llongarray)
//		assertEquals(model.m_bool_array, compareModel.m_bool_array)
//		assertEquals(model.nbool, compareModel.nbool)
//		assertEquals(model.oboolarray, compareModel.oboolarray)
//		assertEquals(model.pdate, compareModel.pdate)
//		assertEquals(model.qdatearray, compareModel.qdatearray)
//		assertEquals(model.r_json_array, compareModel.r_json_array)
//		assertEquals(model.submodel, compareModel.submodel)
//		assertEquals(model.lotsaSubmodels, compareModel.lotsaSubmodels)
//		assertEquals(model.evenMore, compareModel.evenMore)
	}
}