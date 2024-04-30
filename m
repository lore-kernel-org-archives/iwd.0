Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2814A9D
	for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459763; cv=none; b=lddpLaKesNocwSMpmsk2ikkwOc79VGeZ5zm92y8+UGK0GYuLFVxaKmJSWQ7EgECXNHU3v/1GZmSJpgGNhPWRpFYGxtFojQO0wYgSMKLU/RNUXVfvb8A+Q8CI++IKkb/bpKSrcD8mzxnH1c/ARuaY6YLxImqTjnhUXXX8wzJP6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459763; c=relaxed/simple;
	bh=FgkFxik1kPgwJgaxguainpH8CSPwCxTTPJ+5sBa7PlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6nUQoh1TLr5ONvUYFuzTp1laBUifOKDDW9nQQi+Dgd9UXzxonLISuYh/p4Jb0pLdORCgVcpXZr+ctGgycPWQ5EfsUqDKj/mZc89CYkUyd9QIUl9D9+7wDRBHChJ8bnspjICnfdoZTTcPc1PVMbGtBpoRhi3Yo5WVTS2zbVTwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiCHvw/+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiCHvw/+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34b3374ae22so5555459f8f.0
        for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714459760; x=1715064560; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wP/uZsfMhEpLfbdxC0zOUvaHr9Bp0ZbEktiznpphoU=;
        b=TiCHvw/+fEKa1FpNt5Zwq5owCorN3KVyO2JW5MdV/BiW8peBRPrEukwGthTjZpdXCK
         3hr5ehcNTxit2aeqqIiRe1uqZr/hw1zG4ZoQbhWwRpTYcRHUa3Lu1L5lyaD1vRMjzrXo
         9b64svUqIBNY5CPSfocLAVJ0bp5erZEjHSRrL1ShFQgEVF0K2SM6fJzj6wfLIlmXiW0u
         EcGCZmW/oSu31GYU6fc8OfTys6t1kzgJrLbwrYEpNn6+CIJOgnUj/7+isBkrNgqzLC4a
         cjOBPj94NqF8dSIEn8LV5xjfA6rNqvyzzftS3Uk2AM1NT4hJ0JOcg5E0g1uIaJQvOzYI
         o64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714459760; x=1715064560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wP/uZsfMhEpLfbdxC0zOUvaHr9Bp0ZbEktiznpphoU=;
        b=UA06ScT+LX9ll4E8TfHVxERYpD+Bx56JICkjLfZFHjU2Be7RoXPfT+P7KT6kFv2UyP
         WuiUIe8LP6zdFb8ZNKJU3o0jwpf8CgXzO5MD0RXOzp+5kdmyXp9IDAbb5lNUDNjZqS4l
         khj/dvsnTMrnn6L/5bkbPt3wuOjUZvEa0YsAYFJMuCasZLVI/3DUAfKbrZmfBM9IdE/h
         POQDBxLohwSjySHJSuCEX9yrKzkLSbzovZhBs3o8MN5dKVHhO1nzxkiX6xH40NHaGOtI
         B+bH7W2qzRQD1v8Wr6LxDxbZyke1bLR1oMNgqCXR5j+ux18h08DZ7+5ZxKO7hW8k663l
         vh7A==
X-Gm-Message-State: AOJu0YxEfjT2I48LjVq8+CxLVy4znq2b0guEnyKXObKzZjf4yBeXhSBg
	LbN5bZjB3BZ7OnPPLFiwMHvfjE3iV7iXSCak3Jia0KzbwT9JYBZPN0RLUP8bEA9Z4soPL1Gi8ZH
	qGjpKomhX7dTvX2RghDTxmE9L8fkoIg==
X-Google-Smtp-Source: AGHT+IHRrIG87/Hrl3m0A15uaOdSEMy+Y68yF/LU3WZ1I0BLrkyA6kQOYtkz9U5P5zVmnSiV86DITNua32xkHmPLf1I=
X-Received: by 2002:a05:6000:18a3:b0:34d:1b4c:d014 with SMTP id
 b3-20020a05600018a300b0034d1b4cd014mr4665316wri.57.1714459759401; Mon, 29 Apr
 2024 23:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
In-Reply-To: <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
From: Harry ten Berge <htenberge@gmail.com>
Date: Tue, 30 Apr 2024 08:49:08 +0200
Message-ID: <CAN+yObqYkVrcQzcVr1PXACuGUEeWj3SpTgE6FL2DZxOHnqVPmw@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and WPA3
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

Thanks for your explanation.
Makes sense, and I can imagine that this is a pain for you guys.

Of course I hope that this will be implemented any time soon-ish,
because I really don't want to go back ;-)
Anyways, if I can help in any way, with testing stuff or whatever, let me know.

Thanks,

Harry

On Mon, 29 Apr 2024 at 23:29, James Prestwood <prestwoj@gmail.com> wrote:
>
> Hi Harry,
>
> On 4/29/24 1:25 PM, Harry ten Berge wrote:
> > Hi,
> >
> > I'm not sure this is the right place to ask for some assistance, but
> > here we go...
> >
> > I'm the author for a small Raspberry Pi audio image that is
> > specifically targeting Roon.
> > If you're not familiair with Roon: it's an audio streaming platform
> > targeting audiophiles ;-)
> >
> > Anyways, about a year ago I switched from wpa_supplicant to iwd, to
> > full satisfaction.
> > Better and easier integration, and overall a feel of me being in more control.
> >
> > Now, recently I'm having issues with WPA3 support. This is partly
> > related to firmware (it's just so obfuscated how this all works with
> > firmware from broadcom and firmware from cypress :-(
> >
> > And one of those things is that I can't get it to work on the new Pi
> > 5. Specifically IWD reporting this:
> >
> > Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> > Network is WPA3-Personal...
> > Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
> > CMD_EXTERNAL_AUTH for SAE
> > Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> > Can't use SAE, trying WPA2
> >
> > Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message and
> > advise me to go back to wpa_supplicant. Which is not something I would
> > like to do for various reasons...
> >
> > Do you have any advice for me on what I can do? is this
> > CMD_EXTERNAL_AUTH really related to  this and are you planning on
> > implementing this?
>
> Unfortunately the external auth support is not yet implemented in IWD.
> The brcmfmac driver itself is rather unique being a fullmac driver.
> Depending on how you look at it, this on its own is "easier" to support.
> It handles connecting/roaming all on its own. But then, for some reason,
> someone didn't want to do SAE/WPA3 on the card itself so they came up
> with some one-off mechanism to offload that onto userspace. This is one
> of those things that got put upstream that is a pain for projects like
> IWD to support IMO. Its something we do need to support eventually,
> especially given the raspi 5 requires it.
>
> Thanks,
>
> James
>
> >
> > Thanks
> >
