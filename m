Content-Type: multipart/mixed; boundary="===============5139726761805271964=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] doc: Clarify settings in iwd.ap(5)
Date: Mon, 26 Apr 2021 10:53:45 -0500
Message-ID: <850b3814-6625-fc1f-4b6b-fd45b77c13e3@gmail.com>
In-Reply-To: <20210426132638.758600-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5139726761805271964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
>   =

> -The group ``[IPv4]`` contains settings for IWD's built in DHCP server. A=
ll
> -settings are optional.
> +The group ``[IPv4]`` contains settings for IWD's built-in DHCP server. A=
ll
> +settings are optional.  They're used if network configuration was enable=
d as
> +described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disables
> +network configuration and the DHCP server for this access point.
>   =


Hmm.. If 'all settings are optional', then how do you know whether 'IPv4' g=
roup =

was omitted on purpose or not?

Regards,
-Denis
--===============5139726761805271964==--

