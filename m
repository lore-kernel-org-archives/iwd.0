Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B23A6EF7
	for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252412; cv=pass; b=Zz4EY+wXeukdgm5t7hC/dYJd+yrzydnDGMoakpOxZHgLJUpKVYevJvxeK4f/DQ8kx4OK81Xjy5gFHaUx1yexWOY8PkLXQuVxebMvMHH9bGK/3H7UVNYfNPdU4X6MQWppalCYRJ+wVb4yYdexATRZS1JK0cMRxRBzyyqIQDyUFOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252412; c=relaxed/simple;
	bh=P4Bjcc2g90rCZwpLUPfcYDqywWWZ3CPJdaKkyPaUlPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFST3ZHSpbO5NjF0YcSWDXchEF3XZBLiX31v0LIsRMBt6+VNlSl+FIPfaLouFY1HhZFWeCLrTEHpw5srBSo4eDTWHudG3Rim8dE6861mEcur2gzcnCk/NdyL/HiR9M9txuGZKA4+IZnFCJi9ZKmZ3ofuuzxMaS14aQFvYUlH3aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNVtyxuj; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNVtyxuj"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so501407a12.3
        for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 15:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782252408; cv=none;
        d=google.com; s=arc-20240605;
        b=jcZ9TodV1H9lXs2zGJPQVcNy3ldtyAY6u+h964ecLaTEPm4Zu2Tn90xH+Cli+SumsY
         ximWgRZOrKm79wJwaMkamqqvOEpiyot5i5OfbdKs9LwS11PtMtoe/Uip1l26W1pwsdjR
         TPQFdLF8u6JCXJhe4rxKtVUjQKRVTrg0Z9KVxdWfEcfjtlznHqjBYP411r9pYdKCysKH
         2U2CewRiJnzxl28vTAXnGER1uHjl1rO7VKFg0u5MMKlltD880YhualPCiovgJ7WEiiwE
         mvFmyOhprr7lN577P2Y15NsXwxBSjs8S0Y01iqC2fYZoPLXiiY6X6t7mGayqr9ua42DG
         Cc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        fh=Z2uocKHuQJagY6zFSijdMWdLRAKs2V/F+eKyu7tIYNg=;
        b=gr2ndAemjJOUXC1r6seRYmkHQm3r+VRXy8CsTPqViUTjBXz9qM2LTYRV6D+DpFltkN
         LpMWeJsMY9ovWmc58hGQmF36COPJR9Gq15GvxyEsrXZ+7FcC2gYmo9008O8E/Vt2v9gM
         JjD8nESltTorkv48sAPePnLaSOD4dRVhm6KQ2qz9t9VaZ3jClWlqc/7vbN4xB4vC6HI5
         thfKl18SBX1mqyjPSsjMYzGHeU7mq0WIvECzk6mRVaY077T9V5Qa2u4YWo6RNwlfnjXR
         NEre/q5uAMyGHeVbdrNwWJsomd7JMK11NQH2mNgr9sgp4MZe/iH/KYZiOJSzSOHtAwLz
         BibQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782252408; x=1782857208; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        b=nNVtyxujzWnPqGtXbXLNwDOSmuLSV4+7vPTHzfNxZfH5FUWJvUkuHmbDgbiTyMUL+l
         xbZ/iAx/XbOS7zNKSyUYrMTjvoAMysLNn8LoXNiMRiTHe/RnZ1F6t+U2BvMLkZKEVNJt
         iSp5bKeTw1qublwOlevEyvQUZlCPm0XPIOqGwreublK/y3LBASSzjqXjKbbwib89Y/xL
         alD0YIIPh6krXtkdqNRE2pRHGR2pa8mEUQZ3id/7DiM4qrXYokcns1mt3WukLvDXIuW2
         9NTOXA/b4/T2hybt5Bw7A3NW+vzNOkyOsti3o+g6GkWJ5yAaYQ5C/YapMkkz06Q8Xx8+
         LG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252408; x=1782857208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        b=VaJeHmoNq1LHRGgP4+f3y+DFxv2ZX5632qoqX2P/DtQm+UuSLhPz8daEeCicju/2wO
         vvDv10rfZvFlJwzznv9g5hLlDiEr7w13o4tYcR6O3Y+iQwVTxnjcMdDPBXfGFLKTKfRZ
         V1LOI2FAx2xbUxQ1j2LeebQR28vcwbP8nAwYoy2dagBIpC7PwCf7MagQs43V+cZb8BP/
         urMhMNnh56IMmerhHGOMqNvUaK4rBS7vZBCE9bTCCAyVHQLV/8MaVY/Nz7C7A/9Q8Wj5
         lSW9Mjt5hQSJSX4dSlGoO8UV9VIjGl2eObADlN5QlG/Hc238nMBFuy1zlerf7o2C/8CZ
         E/yA==
X-Forwarded-Encrypted: i=1; AFNElJ+2PFnG46b5KCauHxz+i4P9QpDjX8oG73YzdsJndi7egVGsbkVSDulUkNZSPeZgRCb5tnY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYDqw1VQtH7sER5ww90N8xZRSvwSZbq6jcOakto3lueb5ogvVS
	LdCGDuWJpJH0PMOF9xjBygUz1ZgjS2obcHdC3iYv2nfDDOMTJXPlSAY2vSuCyfUt+5Zt9ecZLGU
	TPViIGMMQLUjrC9LhnGecuP6G9y/+2mg=
X-Gm-Gg: AfdE7cnQP2UrYvYTw2Qw1OeZyUmtA/lZqw8Gs1KLa5bQ6EX9YWjW/M0NLlioisFbE1Q
	G1kdIhIxyHHaDKEQZyabeEjyXpUl5Kr4c1AB86Q1U8J7zzz1x02BiKNsPwZ2ZTlSY3fWoh8RUnp
	snmiol88LEjFPrXIYwInIc/gMDAsG0mjNYhiA14E/L63EVLY6kCP46rpRQf6p1Xg8eDRi8qnbic
	YiRph8JcJANmzZPYfey1w8Nue6rBW9tZIavquxC7sZwCqC4LdPYxjB22O0TnxAiMKDr0X/zywg8
	2spIoJywKzsqbfXoOAXy1TdMQZCBD9IASQ6vkqhNbJ9rtJl8DXknRr12rMsxcp5jkFcYbJOO9ef
	HSbsXN1UWUkR4Cd7zDUMLLhBYAbF5KpWu9AFfXzXO1+mGXQ==
X-Received: by 2002:a05:6402:146e:b0:68d:235a:cdaf with SMTP id
 4fb4d7f45d1cf-697f377116bmr189804a12.5.1782252407504; Tue, 23 Jun 2026
 15:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org> <CAKxU2N_EGTWkvtPOxQXBroxGVXDf1atPoFVyRRu0wHOtEXVWaA@mail.gmail.com>
 <20260623214730.GA3281861@google.com>
In-Reply-To: <20260623214730.GA3281861@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 23 Jun 2026 15:06:36 -0700
X-Gm-Features: AVVi8CeboaDakYuMckubiPixxEKhNCjPeUq6olU2uxCUHJDj2YuT_JoocSvKBZ8
Message-ID: <CAKxU2N_yu1LZeNxEUkhahx_5VYML7PZ0-EZfP94p7SmpWbO6qg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:47=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 23, 2026 at 02:28:17PM -0700, Rosen Penev wrote:
> > > +static const struct af_alg_allowlist_entry hash_allowlist[] =3D {
> > > +       { "cmac(aes)", true }, /* iwd, bluez */
> > > +       { "hmac(md5)", true }, /* iwd */
> > > +       { "hmac(sha1)", true }, /* iwd */
> > > +       { "hmac(sha224)", true }, /* iwd */
> > > +       { "hmac(sha256)", true }, /* iwd */
> > > +       { "hmac(sha384)", true }, /* iwd */
> > > +       { "hmac(sha512)", true }, /* iwd, sha512hmac */
> > > +       { "md4", true }, /* iwd */
> > > +       { "md5", true }, /* iwd */
> > > +       { "sha1", false }, /* iwd, iproute2 < 7.0 */
> > > +       { "sha224", true }, /* iwd */
> > > +       { "sha256", true }, /* iwd */
> > > +       { "sha384", true }, /* iwd */
> > > +       { "sha512", true }, /* iwd */
> > > +       {},
> > In OpenWrt, https://gitlab.com/linux-afs/kafs-client and strongswan
> > seem to be the other users of the user API. I haven't looked into what
> > they need.
>
> [Please trim your replies, thanks!]
Not sure what you mean.
>
> https://gitlab.com/linux-afs/kafs-client uses AF_ALG only for
> "hmac(md5)", which I already put on the privileged allowlist due to iwd
> also using it.  So it would still work by default with the current
> patch, unless it needs to use it unprivileged.
>
> (FWIW, a use of a single obsolete algorithm like this is also a good
> candidate for just replacing with local code...)
>
> https://github.com/strongswan/strongswan already supports userspace
> crypto libraries.
Oh lovely. Looks like this needs fixing in OpenWrt.
>
> - Eric
