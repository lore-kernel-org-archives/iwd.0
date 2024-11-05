Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC113D52E
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831025; cv=none; b=GGK5B6MfWxfJWWl7K27coP+pouFaxmMoNb8ECrpJ9RKtYOGj0yFdyPkt6eJ35PJAqbUFRGHJnjSdny2v4ASKqvb24wFMbF+hNRtQwsw4BK628NxvRTyPaRJVK32+wCjjn51Yt8G734QuqWeSXAXOYhDE0mJCcnbu9yBC+8+xEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831025; c=relaxed/simple;
	bh=fc9JvJzdYTDLwCxM37nlwqf8kgop+sABVf3Hr8sxL08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DEdyZh7Ujo0U8pgYbvhT1eIFDKtBwGJkkGg2PPrbBV0ZEIX+XiD1c8xksc3AWTzUFtOFC9eYY6XDZBZKb+JEXLRjgvTpkcpa9Kt3KyRKq+9mC2PvYbYaYzoevKploke/N1toceHY+VhaXCw0KpqeqCfHpMlnJb3ts3ANoAYVng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfAWda8Q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfAWda8Q"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso4437834a91.2
        for <iwd@lists.linux.dev>; Tue, 05 Nov 2024 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730831022; x=1731435822; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fc9JvJzdYTDLwCxM37nlwqf8kgop+sABVf3Hr8sxL08=;
        b=OfAWda8QoXaQ/Y1yIwskcT3cbEXda/OsrILxIr7G0Vgg8MvYwpmm/9tRbIjcmy7WkV
         z4xBNlBbe+AWrVW0F1fDPd4O0tSXNR4fxaLfcfMJkU2d+nXIVSVoNg3B3VY/Wk6i5TEX
         ndKgOJ/1oKBLMMZlqjX0DuvtUhW/4RREzDq0GdBMRVVyaHgwt16RvBTUspAmBW/IH104
         02aYo1a248fJfmWB/8047Fz4IsYLAdXx/LBt4UqIS3FAWJaBJxmnoipANp8OdLrikd1d
         2fmr1Sg3KeN0apRObPiOLxETsy8lPf0ZZiAqjF7rJuAfjL3XAb745xnVrU26Zz7vg7up
         23/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730831022; x=1731435822;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc9JvJzdYTDLwCxM37nlwqf8kgop+sABVf3Hr8sxL08=;
        b=gzbMeRMeq1ALdm6y5qH3+WRTK5WnLlNY0Xis2K1ifYl2ui7+2mP2lxYKppPSkqYt8U
         EU4CTYXy+JKS2c7KK5p2dsuzCbtfJ6M1/QZm6eAKEoebBoNzn8bOTWiYlSdv2c+UcB1z
         J06UAOswxHyxb/u/ScWjJ3qD5WVgkvXsPCUEDVmgHvykgSCluzJjqKPDsahiq5dLRL0Z
         SoeUySWcD2DvdK+Hsym/cviJyl0mlEpzanuw870fsxzmZ4TWGhjAOBW0O3QiQBxVU+21
         AHf6ibs4QCDtgdA8bmWV6MawTQ3OKGn2Jy6nA4Yhe3cViNHQH7ZdUqIgSfmLZMhi1tcn
         ltrw==
X-Gm-Message-State: AOJu0YwilU/x+qUG9WAVsQE37VxLpEX+1RW8cJ6tWhoYmdK1vZBoJyqw
	MUy4HhpgjMbC27fV1vUSYC+aZzKMYP2getz0GWyU7IdgzLg3jyT6SIDr9CD1NhBNyRI9pnXDtTt
	HBbFQEepWn4cYojJ1Ur0yl9BvRtEJKg==
X-Google-Smtp-Source: AGHT+IG3vnMHDLn1mApEcYCnmC+n9496jGUYK8MOK2sANtmz9BwFprigaGSvvAjwwKmiZ9n8aU1H0jJSMEtq7flORWM=
X-Received: by 2002:a17:90b:3ec8:b0:2e2:b41b:854e with SMTP id
 98e67ed59e1d1-2e94c2e588dmr25717828a91.20.1730831022424; Tue, 05 Nov 2024
 10:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
In-Reply-To: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
From: Harry ten Berge <htenberge@gmail.com>
Date: Tue, 5 Nov 2024 19:23:30 +0100
Message-ID: <CAN+yOboCgTLninh255t6Z61S1PaKXjS0yj1HTx5LU9c5dzyS_g@mail.gmail.com>
Subject: Re: timesync when using IWD stand-alone
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 19:15, Martin Petzold <martin.petzold@tavla.de> wrote:
>
> Hi all,
>
> if I configured my Ethernet interface via systemd-networkd and there is
> NO carrier (no cable connected). But my wifi is configured, managed and
> connected by IWD (EnableNetworkConfiguration=true). In a typical case
> there is no other NTP server configured in timesyncd.conf. How will
> systemd-timesyncd sync the system time?

Is there a specific reason why you have chosen for IWD to handle the
network configuration?
I use IWD in combination with systemd-networkd all the time, and it
works like a charm. In that case systemd-timesyncd also works
'out-of-the-box.

Thanks,
Harry
