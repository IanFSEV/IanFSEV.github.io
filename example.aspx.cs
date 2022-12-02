using System;
using System.Web;
using System.Web.UI;
using System.Security.Cryptography;

namespace Example 
{
	public partial class Ipa : System.Web.UI.Page 
	{
		protected string _apiKey = "F5BBD5301ADDF1F2AD6447191B0699EE";
		protected string _secretKey = "8A0DF12CAB59EB58975D9E847A2561EF95CDA179BF8DDDDDCC283AC2BFDFF06EA9DC62B8871A02DCCCD980EFAD665251B379ADC2E4278ADA3427DBFAC1A90EAB1C166AB537FB446EFE5445A7FC94A922F6178052912209689AFF4598FD9BC58FB88602E4A402C79A2960BE72B4DE446E82B66868237F7689AC85DDF1D4DD07E1";
		protected string _ipaLoadUrl = "https://pol.pictometry.com/ipa/v1/load.php";
		protected string _ipaJsLibUrl = "https://pol.pictometry.com/ipa/v1/embed/host.php?apikey=F5BBD5301ADDF1F2AD6447191B0699EE";
		protected string _iframeId = "pictometry_ipa";
		
		public string iframeId()
		{
			return this._iframeId;
		}
		
		public string ipaLoadUrl()
		{
			return this._ipaLoadUrl;
		}
		
		public string ipaJsLibUrl()
		{
			return this._ipaJsLibUrl;
		}
		
		public string signedUrl() 
		{
			// create timestamp
			TimeSpan span = (DateTime.UtcNow - new DateTime(1970,1,1,0,0,0,DateTimeKind.Utc));
			long ts = (long) Math.Floor(span.TotalSeconds);

			// create the url
			string url = this._ipaLoadUrl + "?apikey=" + this._apiKey + "&ts=" + ts;

			// generate the hash
			System.Text.ASCIIEncoding encoding = new System.Text.ASCIIEncoding();
			HMACMD5 hmac = new HMACMD5(encoding.GetBytes(this._secretKey));
			byte[] hash = hmac.ComputeHash(encoding.GetBytes(url));

			// convert hash to digital signature string
			string signature = BitConverter.ToString(hash).Replace("-", "").ToLower();

			// create the signed url
			string signedUrl = url + "&ds=" + signature + "&app_id=" + this._iframeId;

			return signedUrl;
		}
	}
}