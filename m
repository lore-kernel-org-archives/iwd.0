Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C0152507
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565615; cv=none; b=IBDkYy79gsE+c5DPjnz5kmgBr7UjZ8I46kkPIcHCfgazKrf8BMo2O7g90alMcUyDfXnm623x4Se17zzGGJ5M2nvC/E4mcAyQlQOqniiZBFhKnklcFOQGMvWlRHn/AwgkRW0sJvYu10owBu/8+xIBgG+PIPRCt2C0rSfT964Mumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565615; c=relaxed/simple;
	bh=PAdWW+lSZ5OPIRDZxbX4pd3+g/BUBdh7JUIH2BpjNB4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=h+OZwNU7TFG4UtloGNyxVw3nrxUEqjIHytCrAs4jCEPAwPFP2HaDladbVdAu943pmnrvaE9pqvHZeJgk6u4TZMvJ3EKxtNlwGWF/OS1p1zQv8t4X8FAXNR4xxCPgGM7u0oLD6jizE202ptXEEj1/HNpp2QL2DekisgjzIbW3I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id CD19A3782112;
	Wed, 27 Mar 2024 18:53:31 +0000 (UTC)
From: "Jeremy Whiting" <jeremy.whiting@collabora.com>
In-Reply-To: <2959f53a-e038-4b17-9b12-26a1901842c0@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240326231151.607163-1-jeremy.whiting@collabora.com> <2959f53a-e038-4b17-9b12-26a1901842c0@gmail.com>
Date: Wed, 27 Mar 2024 18:53:31 +0000
Cc: iwd@lists.linux.dev, ed.smith@collabora.com, alvaro.soliverez@collabora.com
To: "James Prestwood" <prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <2cc42d-66046b00-3-734beb8@251373457>
Subject: =?utf-8?q?Re=3A?= [PATCH] Register EAPOL frame listeners earlier
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 27, 2024 05:51 AM MDT, James Prestwood <prestwoj@gm=
ail.com> wrote:

> Hi Jeremy,
>=20
> On 3/26/24 4:11 PM, jeremy.whiting@collabora.com wrote:
> > From: Ed Smith <ed.smith@collabora.com>
> >
> > If we register the main EAPOL frame listener as late as the associa=
te
> > event, it may not observe ptk=5F1=5Fof=5F4. This defeats handling f=
or early
> > messages in eapol=5Frx=5Fpacket, which only sees messages once it h=
as been
> > registered.
> >
> > If we move registration to the authenticate event, then the EAPOL
> > frame listeners should observe all messages, without any possible
> > races. Note that the messages are not actually processed until
> > eapol=5Fstart() is called, and we haven't moved that call site. All
> > that's changing here is how early EAPOL messages can be observed.
> > ---
> >   src/netdev.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/netdev.c b/src/netdev.c
> > index 09fac959..fc84c398 100644
> > --- a/src/netdev.c
> > +++ b/src/netdev.c
> > @@ -2982,8 +2982,13 @@ static void netdev=5Fauthenticate=5Fevent(st=
ruct l=5Fgenl=5Fmsg *msg,
> >   						NULL, netdev->user=5Fdata);
> >  =20
> >   		/* We have sent another CMD=5FAUTHENTICATE / CMD=5FASSOCIATE */
> > -		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN)
> > +		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN) {
> > +			if (!netdev->sm) {
> > +				netdev->sm =3D eapol=5Fsm=5Fnew(netdev->handshake);
> > +				eapol=5Fregister(netdev->sm);
> > +			}
> >   			return;
> > +		}
> >  =20
> >   		retry =3D kernel=5Fwill=5Fretry=5Fauth(status=5Fcode,
> >   				L=5FCPU=5FTO=5FLE16(auth->algorithm),
> > @@ -3099,9 +3104,6 @@ static void netdev=5Fassociate=5Fevent(struct=
 l=5Fgenl=5Fmsg *msg,
> >   			netdev->ap =3D NULL;
> >   		}
> >  =20
> > -		netdev->sm =3D eapol=5Fsm=5Fnew(netdev->handshake);
> > -		eapol=5Fregister(netdev->sm);
> > -
> >   		/* Just in case this was a retry */
> >   		netdev->ignore=5Fconnect=5Fevent =3D false;
> >  =20
>=20
> I need to have the CI email the original sender so you get notified, =
but=20
> as Denis mentioned this still breaks FT because IWD does not use the=20
> conventional CMD=5FAUTHENTICATE and instead sends an auth frame using=20
> CMD=5FFRAME. This means that there is no authenticate event at all wh=
en FT=20
> is involved. Because of this, no SM gets created (with this patch) wh=
ich=20
> breaks rekeys.
>=20
> After FT authentication netdev=5Fft=5Freassociate() is called which i=
ssues=20
> the CMD=5FCONNECT call (this triggers association). So I think you wo=
uld=20
> need to both create the SM similar to where you did here, as well as=20
> after it gets destroyed in here:

I think I see. I've got a couple of questions though.

1. How if possible can I run the CI tests locally?
2. Should I instead just change the eapol=5Fregister that we removed fr=
om =5Fassociate=5Fevent to keep doing the =5Fregister if netdev->sm is =
null?
i.e. Change the patch from removing the 2 lines to wrapping them in
if (!netdev->sm) {
}

At any rate I just sent a new patch with the suggested addition of regi=
stering after freeing in netdev=5Fft=5Freassociate. I can test that thi=
s afternoon, or try the other approach as well.

thanks,
Jeremy

>=20
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/netd=
ev.c#n4279
>=20
> For reference, this is the CI output with this patch:
>=20
> **Autotest Runner**
> Test ID: testrunner
> Desc: Runs IWD's autotest framework
> Duration: 1868.49 seconds
> **Result: FAIL**
>=20
> Output:
> ```
> testFT-8021x-roam,testFT-FILS,testNetconfigRoam,testPSK-roam,testSAE-=
roam
>=20
> Thanks,
>=20
> James
>

