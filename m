Content-Type: multipart/mixed; boundary="===============4135827054019123242=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: denial-of-service vulnerability in 4-way handshake
Date: Mon, 09 May 2022 13:50:56 -0500
Message-ID: <6f30f047-0e8a-69cd-c9f1-a446080f82bb@gmail.com>
In-Reply-To: 22F152D7-6A5D-4AEA-B2EB-D3C54462409F@northeastern.edu

--===============4135827054019123242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Domien,

On 5/6/22 09:00, Domien Schepers wrote:
> We discovered a denial-of-service vulnerability that allows an adversary =
to forcibly disconnect the IWD client from a protected Wi-Fi network even w=
hen Wi-Fi Management Frame Protection (MFP) is being used. The problem is t=
hat the reception

Looks like kernel/driver is letting through an unencrypted EAPOL Data frame=
 even =

when we're already set up encryption keys.  MFP won't really be of much hel=
p here?

  of an unprotected and invalid handshake message 1/4 will cause the client=
 to =

disconnect even when MFP is used, resulting in denial-of-service.
> =


<snip>

> A potential solution is to discard the invalid handshake message instead =
of disconnecting.

Yes, this particular symptom could be fixed in this way.  802.11-2020 does =

explicitly state in section 12.7.2 that "EAPOL-Key frames containing invali=
d =

field values shall be silently discarded."  So I think I'll send a patch th=
at =

does that.  But even then, we'd still be open to other forms of similar att=
acks.

The real fix is that we should not allow unencrypted EAPoL 1/4 packets (or =
EAP =

for that matter) to be processed once the keys have been set (with the cave=
at =

that there is special case of EAPoL 3/4 packets that are being retransmitte=
d =

during the initial handshake.)  Unfortunately, 802.11 never explicitly requ=
ires =

this that I can find.

In theory the EAPOL over NL80211 transport does provide us with a hint that=
 a =

packet was received encrypted or unencrypted.  So we could try and drop any =

unencrypted packets after the initial handshake is complete and the keys ha=
ve =

been set.  But I'm not sure whether this hint can be always trusted?  Also,=
 the =

legacy PAE raw socket transport also doesn't provide this information.

Did you bring this up with the kernel wireless maintainers by any chance?

Regards,
-Denis
--===============4135827054019123242==--

