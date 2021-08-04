Content-Type: multipart/mixed; boundary="===============4280655170715453421=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [connman v1] wifi: Set ieee80211w as required for
 WPA3-Personal-only mode
Date: Wed, 04 Aug 2021 18:17:20 -0300
Message-ID: <39fccc8f-4f53-ccff-97ba-194258f07923@collabora.com>
In-Reply-To: <20210803074104.dawii3v3bknovg2e@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4280655170715453421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 8/3/21 4:41 AM, Daniel Wagner wrote:
> Hi Ariel,
> =

> Thanks for tracking this! Just a stupid question:

Thanks for the quick feedback :-) see below.

> =

> On Mon, Aug 02, 2021 at 12:10:06PM -0300, Ariel D'Alessandro wrote:
>> From wpa_supplicant docs [0] section "ieee80211w":
>>
>>   "WPA3-Personal-only mode: ieee80211w=3D2 and key_mgmt=3DSAE".
>>
>> This means that the parameter ieee80211w has to be set to 2 (required)
>> if SAE is used. Fix it.
>>
>> [0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
>> ---
>>  plugins/wifi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/plugins/wifi.c b/plugins/wifi.c
>> index 578b4be7..02603e85 100644
>> --- a/plugins/wifi.c
>> +++ b/plugins/wifi.c
>> @@ -2174,7 +2174,12 @@ static void ssid_init(GSupplicantSSID *ssid, stru=
ct connman_network *network)
>>  	security =3D connman_network_get_string(network, "WiFi.Security");
>>  	ssid->security =3D network_security(security);
>>  	ssid->keymgmt =3D network_data->keymgmt;
>> -	ssid->ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
>> +	/*
>> +	 * From wpa_supplicant docs:
>> +	 * "WPA3-Personal-only mode: ieee80211w=3D2 and key_mgmt=3DSAE".
>> +	 * Set ieee80211w as required, which is sent if SAE key is used.
>> +	 */
>> +	ssid->ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;
> =

> Should we check the keymgmt is SAE and only then set the ieee80211w
> value?

Thanks for asking that, two answers:

* `ssid->ieee80211w` only gets sent if key management is SAE, so that'd
be redundant. See this code block [0]. So, there's no real need to check
the keymgmt is SAE here, and `required` could be the default value.

* On the other hand, my concern now is about supporting SAE transition
mode. Let's *drop* this patchset and I'll send an RFC patch implementing
WPA3-Personal transition mode.

Thanks!
Ariel

[0]
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/gsupplicant=
/supplicant.c#n4908
--===============4280655170715453421==--

