Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F33BB22
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926099; cv=none; b=hARg5uBOGWG7FpHTUolLPyLsbMNw6J7TLZ/nk4qABfUWuQeLTDrHmK4M9FkqB/dl3JfsstccUFaiWpUhLMpFmbzpNsvgut67v09Wb77cuESpRx4p3ZC1mCzIIoOISDA0uWSXYoNByTx9+bTh1Mh/WQeU46/2yg6SsvG8bd8rf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926099; c=relaxed/simple;
	bh=94RW5vGh+Y05a9JEZRuhvx8i5914OfmdIzbPK/EzFnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r/vbVNU+1kA5Iqg/oN36Gpe5n6nFmjwXBb60SOo7tcJtd3sfKo4RaCcnnx1f2v8Jt2XgkrqNSUF1d5hPTPftMnA8EY9oXOkIdtBMC4hWgWaPZ2JdXshGxeKzQSDp9tuC0+HBxURz9LXe8xQ8W85WNs9EE0pqz8dc1Q+z17wxcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVcsU8Dl; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVcsU8Dl"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598ee012192so1318310eaf.1
        for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705926097; x=1706530897; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNOeO9N9D//sNoWGBh7vnV2EBunYHSqzHZEmghLqh3A=;
        b=kVcsU8DlIudcccjrDJSqK6EVRkJbm6e6oJ/ty++aGB5EuXyAMU53xnuHxI23CAK5xl
         gj75Wm0HhFJwt/uyekM10x/IVldS+mDpejEaMuCB2A1kcrVEAZP7ylM/Ayg7Yghzl+hp
         o4VSn7afqZU8rQmdYvZSW/Ex83zv/upmPzlnwyBPUtOfNM+7v3LE9M8cgZCGUmbLIv9X
         MHfazpfap07Qy6t4CLoCPvhddhUemcNgsev/MPptQiAtxbnd3/eKo2QeLbQq6UZQ1Oim
         rt0G1J67Qh/uw6y8wJ1c2GRtt3J+ruJ4dbh+ySZMGxCp/Tj8rUwHExJ4jtqkkxTgjdhB
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926097; x=1706530897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNOeO9N9D//sNoWGBh7vnV2EBunYHSqzHZEmghLqh3A=;
        b=ukpRNWrExv1q2Q877RO/kuvON0xlR7oFFUTwkZ/oIzlb4I6U2K7YqiSbbCjs7XDr5+
         AHS+8XW0iqJEuIY9UxbbYeYMnQ/gBkOKfDT1Je5fnxReaFgMGE+79aCkMwt8zF63crSv
         YP3SgEGCkDH/+P8fJNb71EZgiofYawVRt/LnI1h7xKfU2C7rh71EvOtx/0fcytNUiB10
         T3ySb/lxx/AiVIGKzTxravT4DR2POVEG0UI8yc+Buc6zD/ELUws5Tlnp5PH8p2uHtapb
         JfnayRHBn0UjODmnbi0KfpOJbV8O98xsKnzN3uJXCoAT7Q0yKW6+g8llawETrNF4CTmS
         0i/Q==
X-Gm-Message-State: AOJu0Yw+ltkPfVUDz9z2gsbLvxhORiLUNGTZfDNvEmSmG185U3yVC0xX
	/0jModkOELjWkAjdoPXBP9CVaRBnzTHCVaamBSKktBZbi2nmbnot
X-Google-Smtp-Source: AGHT+IFPueoMjUtiJNYU2lm0ngRxxohoOp36l0ga/6hLhZtGSmnu6ojfgifoOpnm1q5l/x9OYq1WkQ==
X-Received: by 2002:a05:6358:419d:b0:175:ea27:a375 with SMTP id w29-20020a056358419d00b00175ea27a375mr1692875rwc.60.1705926096866;
        Mon, 22 Jan 2024 04:21:36 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id kv2-20020a056214534200b00681896c0483sm2354343qvb.114.2024.01.22.04.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:21:36 -0800 (PST)
Message-ID: <e1a35af8-0c7c-450b-9d96-fa8987e4c0d4@gmail.com>
Date: Mon, 22 Jan 2024 04:21:33 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Making udhcpc get a new lease when iwd connects to a network
To: =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>,
 iwd@lists.linux.dev
References: <87h6j670ye.fsf@espindo.la>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87h6j670ye.fsf@espindo.la>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 1/21/24 2:53 PM, Rafael Ávila de Espíndola wrote:
> Hi,
>
> I know that iwd has a builtin dhcp client, but I am using it in alpine
> linux and would like to use the same dhcp client with both wired and
> wireless interfaces. The default client in alpine is udhcpc.
>
> As far as I can tell, the impedance mismatch between udhcpc and iwd is
> that udhcpc expect commands via unix signals and iwd send property
> changes via dbus.
>
> I wrote a bit of glue code and posted it to
> https://codeberg.org/espindola/iwd2udhcpc. It works, at least on my
> laptop, but I am wondering if anyone knows of a simpler way.

I think the intended way is for the DHCP daemon to listen for the 
interface to set carrier up (from RTNL). This is how systemd-networkd 
does it, and AFAIK dhcpd. I'm surprised udhcpd doesn't although I 
suspect since its heavily stripped down they leave it up to some other 
entity to tell it to start.

Listening for IWD's connected state is effectively the same thing. One 
thing to keep in mind is you don't want to start DHCP again when 
transitioning from roaming->connected.

>
> Thanks,
> Rafael
>
