Content-Type: multipart/mixed; boundary="===============0844086958173939446=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] eap-tls-common: Address PEAPv0 interoperability with
 Windows
Date: Mon, 03 Feb 2020 11:35:01 -0600
Message-ID: <f3708708-e600-90f9-ad6f-470efa67c5ed@gmail.com>
In-Reply-To: <20200131222517.8182-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0844086958173939446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 1/31/20 4:25 PM, Tim Kourt wrote:
> Windows Server 2008 - Network Policy Server (NPS) generates an invalid
> Compound MAC for Cryptobinding TLV when is used within PEAPv0 due to
> incorrect parsing of the message containing TLS Client Hello.
> Setting L bit and including TLS Message Length field, even for the
> packets that do not require fragmentation, corrects the issue. The
> redundant TLS Message Length field in unfragmented packets doesn't
> seem to effect the other server implementations.
> ---
>   src/eap-tls-common.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> =


patches 1-3 applied, thanks.

Regards,
-Denis

--===============0844086958173939446==--

