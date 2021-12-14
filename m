Content-Type: multipart/mixed; boundary="===============2998755105311369572=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 10/10] doc: document DPP interface
Date: Tue, 14 Dec 2021 15:35:03 -0600
Message-ID: <bcbc931a-8e98-2286-d5ba-da32ccec312f@gmail.com>
In-Reply-To: 20211214181225.2308043-10-prestwoj@gmail.com

--===============2998755105311369572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/14/21 12:12 PM, James Prestwood wrote:
> ---
>   doc/device-provisioning.txt | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 doc/device-provisioning.txt
> =

> diff --git a/doc/device-provisioning.txt b/doc/device-provisioning.txt
> new file mode 100644
> index 00000000..444bac74
> --- /dev/null
> +++ b/doc/device-provisioning.txt
> @@ -0,0 +1,32 @@
> +Device Provisioning hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Service		net.connman.iwd
> +Interface	net.connman.iwd.DeviceProvisioning [Experimental]
> +Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
> +
> +Methods		string StartEnrollee(dict arguments)
> +
> +			Start a DPP enrollee. Currently only station devices are
> +			supported. The method arguments should be a dictionary.
> +			There are no required dictionary key/values but it may
> +			include:
> +
> +			Information: string - Vendor specific info to advertise
> +						in the URI (I:).
> +			Host: string - Host information to advertise in the
> +						URI (H:).

Do we really want the users to provide this or should we simply grab it fro=
m =

gethostname()?

Are there limits on the contents of the information / hostname strings?

> +
> +			Returns the enrollees URI
> +
> +			Possible errors:	net.connman.iwd.InvalidArguments
> +						net.connman.iwd.AlreadyExists
> +						net.connman.iwd.NotAvailable
> +
> +		void Stop()
> +
> +			Stop an enrollee.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.Failed
> +						net.connman.iwd.InvalidArguments
> =


Regards,
-Denis
--===============2998755105311369572==--

