Content-Type: multipart/mixed; boundary="===============4472682300146965038=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] wscutil: Allow 0-length attributes in wsc_attr_builder
Date: Tue, 25 Aug 2020 16:49:46 -0500
Message-ID: <2ac1c8f6-9ca0-c4fa-0758-344555e0017e@gmail.com>
In-Reply-To: <20200824223426.475779-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4472682300146965038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/24/20 5:34 PM, Andrew Zaborowski wrote:
> wsc_attr_builder_start_attr and wsc_attr_builder_free look at
> builder->curlen to see whether the TLV's length needs to be updated to
> include the previous attribute.  If builder->curlen is 0
> wsc_attr_builder_start_attr assumes there's no previous attribute and
> starts writing at current builder->offset.  If the previous attribute
> length was 0 curlen would stay at 0 and that attribute would get
> overwritten with the new one.  To solve this add the 4 bytes of the T
> and L to curlen as soon as a new attribute is started, and subtract
> them when writing the L value.  The alternative would be to set a flag
> to say whether an attribute was started.
> =

> The spec explicitly allows 0-length attributes in section 12:
> "The variable length string attributes, e.g., Device Name, are encoded
> without null-termination, i.e., no 0x00 octets added to the end of the
> value. If the string is empty, the attribute length is set to zero."
> ---
>   src/wscutil.c | 38 ++++++++++++++++++--------------------
>   1 file changed, 18 insertions(+), 20 deletions(-)
> =


All applied, thanks.

Regards,
-Denis
--===============4472682300146965038==--

