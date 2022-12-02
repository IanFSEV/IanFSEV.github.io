using System;
using System.Web;
using System.Web.UI;
using System.Security.Cryptography;

namespace Example
{
	public partial class Ipa : System.Web.UI.Page
	{
		protected string _apiKey = "";
		protected string _secretKey = "";
		protected string _ipaLoadUrl = "https://pol.pictometry.com/ipa/v1/load.php";
		protected string _ipaJsLibUrl = "https://pol.pictometry.com/ipa/v1/embed/host.php?apikey=";
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
