Content-Type: multipart/mixed; boundary="===============4881887313302142577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Thu, 05 Aug 2021 21:10:25 -0500
Message-ID: <4af22a81-e447-0f79-e9d3-062e6148d3ff@gmail.com>
In-Reply-To: <CACsRnHX0yR+SnWGPPtKkKQGGdcRn=pySxjyFy4eQmG-YkfAoqw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4881887313302142577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/3/21 12:41 PM, Michael Johnson wrote:
> Hi Denis,
> =

> On Tue, 3 Aug 2021 at 17:35, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hmm, I wonder if we have a different bug here.  This gives me a few idea=
s to
>> look into, let me poke around and I'll get back to you.
>>
>> What other problems are you having?
> =

> Thank you!
> =

> The other major problem I'm having is when 802.11v is enabled the APs
> are not sending BSS-TM frames during re-associations (i.e. FT roams)
> but it does work during a full association.
> The current suspect is that the client doesn't send the "extended
> capabilities" tags in the re-association frame like it does with a
> full association. Without this the Meraki APs assume the client
> doesn't support it.
> I don't know what the standard says about this one.
> =


I believe I have fixed this upstream now with commit 8f9e6b3f7626 ("netdev:=
 Send =

addititional IEs for FT/SAE/OWE/FILS")

Can you give it another try?

Regards,
-Denis
--===============4881887313302142577==--

