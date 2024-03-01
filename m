Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF24394
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305230; cv=none; b=jInsbveSxTWzBIMpst9+e3KgdcJZkgC3d27NU/fhbAx9jvzSpVXT/5DLxzSPPIoFqz0B4dBQGgndkZolP4MLbdNRkIydtvVJtOWAWD+UV0s3GCxAW7ZZOg8AkMXXtp/Oujg/a4EZct5awd75rrmbbFFzQkgrz1JkpNxgSkMSc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305230; c=relaxed/simple;
	bh=J6U2mk57HYVoMEQyycBXRRJVCE93LXgIXsSkBn9cuVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaecinaQ80DxP2XQ+fxMh0Jg4HChhwA/M8gmRkFVUulhUSzorApCLnrZmcVtP0t9PP94/y+oXl7mVVNa3FrGkW5kLhhRNVWiI+7TnrBK3znzDXS1pZC2EUG6JzWsX3xPDKCIj7LrXHdRq0Ag5DOPOlabEtSaTpMAR5i/zpH7XqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy7Aj8qQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy7Aj8qQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e152c757a5so1543727a12.2
        for <iwd@lists.linux.dev>; Fri, 01 Mar 2024 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709305228; x=1709910028; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8hhl7c+KuYFGnw9ZxwwvQ+GPFik1gUuJAGqzSaQfUE=;
        b=Sy7Aj8qQOcBf6g4XAwE+XGC12Fg1RYnOsSAZipc2im7MJJnhUpNXEf/IsUY809E39V
         kxX7OuAncpEz324gjq2cgkORnkaKnADfW4gsDyNqHQVnJ3eA5niejphTMcRWPxuuOzyQ
         Uxc6jGGhbwKNCowu6qcBKJXJU1JVVav4KO/HOWOoVn0YniS81zEnbpbG74IXmPfyHKzD
         RMIhC4WclDj3AEA/f1YZwcLDWm+ayaXaW4Cs1DtOgCso3KdHBRDB8pX53cgdRPLtZ0QH
         SwXUu/n+E1XUKrBToua4yYt8eU8Diy4LtaypFBjbaaJ7W6i3We9nqO+CvH/PHvj9Modg
         RXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305228; x=1709910028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8hhl7c+KuYFGnw9ZxwwvQ+GPFik1gUuJAGqzSaQfUE=;
        b=o4OQROrgYl/Au7g9fWphrvDN5sCy+BldnrFe2QgMgv4w/4WdZMm5RvNbFFW1HFInm0
         6RkpzPPodR+emLuLOxjjSN5xGU2kr32tAiK4P+Wno42EdYDhThTHLzBAi5D3Dq8yY8Wm
         Zfgysc49HUGmWt5OpqAZYlB7ha3wsXz2CSNNxYvbwldBYwtaLkyGnsXouW46v8II9KiM
         ny17Cw2Gbp2TZue8y+gVYRhQAzMP8nXcVSU0CHvuU4qaTXU1wL5pFlpDfhsnSZ9/caAK
         gxive1H6RY7Q/HIpLRSUPhqdsJNT/Bcj8zTkgE6rweK7LgWTavptmW6TmTI0ecUjC53h
         zhzA==
X-Gm-Message-State: AOJu0YwejYkHhbNIOuP0F2deOHQPi0Li3QYtmyPntYraHih1NEyVJowy
	tH32khuymVcw9mcnSySLrPCT2JGsn1OTvXAyJmQPEsALCDctfC9d2tWQL+DPMmO+FbPKrxXTg2I
	yg9dp9aoXOkDXR/Xao77vBLdQZ2w=
X-Google-Smtp-Source: AGHT+IEcHC3DYF+OsIcrraOlPIwhWliDtctbq1cKL/pjLIYlCRjWw74emJcIHqEp8FbpHhbBF5Z9zUeQ+JbnrlWAcv8=
X-Received: by 2002:a17:90b:808:b0:29a:dae0:ad68 with SMTP id
 bk8-20020a17090b080800b0029adae0ad68mr1685660pjb.17.1709305228456; Fri, 01
 Mar 2024 07:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240229195654.1579749-1-prestwoj@gmail.com>
In-Reply-To: <20240229195654.1579749-1-prestwoj@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 1 Mar 2024 09:00:17 -0600
Message-ID: <CAG17S_NZYsRcgRRCWDVNzPPxBem4kQ3u-9Fc7U0eNUowiynw-A@mail.gmail.com>
Subject: Re: [PATCH] build: Create ell directory for ell/ell.h target
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:03=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Both ell/shared and ell/internal targets first create the ell/
> directory within IWD. This apparently was just luck that one of
> these always finished first in parallel builds. On my system at
> least when building using dpkg-buildpackage IWD fails to build
> due to the ell/ directory missing. From the logs it appears that
> both the shared/internal targets were started but didn't complete
> (or at least create the directory) before the ell/ell.h target:
>
> make[1]: Entering directory '/home/jprestwood/tmp/iwd'
> /usr/bin/mkdir -p ell
> /usr/bin/mkdir -p ell
> echo -n > ell/ell.h
> /usr/bin/mkdir -p src
> /bin/bash: line 1: ell/ell.h: No such file or directory
> make[1]: *** [Makefile:4028: ell/ell.h] Error 1
>
> Creating the ell/ directory within the ell/ell.h target solve
> the issue. For reference this is the configure command dpkg
> is using:
>
> ./configure --build=3Dx86_64-linux-gnu \
>         --prefix=3D/usr \
>         --includedir=3D/usr/include \
>         --mandir=3D/usr/share/man \
>         --infodir=3D/usr/share/info \
>         --sysconfdir=3D/etc \
>         --localstatedir=3D/var \
>         --disable-option-checking \
>         --disable-silent-rules \
>         --libdir=3D/usr/lib/x86_64-linux-gnu \
>         --runstatedir=3D/run \
>         --disable-maintainer-mode \
>         --disable-dependency-tracking \
>         --enable-tools \
>         --enable-dbus-policy
> ---
>  Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index 5ed6ab37..be287572 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -710,6 +710,7 @@ ell/internal: Makefile
>         done > $@
>
>  ell/ell.h: Makefile
> +       $(AM_V_at)$(MKDIR_P) ell
>         $(AM_V_at)echo -n > $@
>         $(AM_V_GEN)for f in $(ell_headers) ; do \
>                 echo "#include <$$f>" >> $@ ; \
> --
> 2.34.1
>
James,

Thanks. I think I ran into this when I built on RPiOS. I hacked my
PKGBUILD to copy the ell directory over to the
after configure. (I use makedeb to build *.deb packages) I would have
to do this when I would build iwd from git HEAD with external ell...

  dbus-run-session ./configure --prefix=3D/usr \
         --sysconfdir=3D/etc \
         --localstatedir=3D/var \
         --with-runstatedir=3D/run \
         --libexecdir=3D/usr/libexec \
         --enable-external-ell \
         --enable-wired \
         --enable-ofono \
         --disable-tools
# build for external ell
cp ../ell/ell/*.h ell/

to build it for external ell...
