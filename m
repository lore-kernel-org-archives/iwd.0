Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55D5FF03
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929218; cv=none; b=eRvYP5sJYwmYXBGfmPpOwmzdhAlkejn26sR2p+hE+UqIpi7mNt7OayFx7BMeEb113HX/QQuvpj+klQG2bXaxY9GniMIRzZzS46ak9jo1PoBBhG3XtoDEUn6/sEYNhk+7ZtuXZmOyiZztX3+tzb91Er6OspNwByYk85oiTvHgMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929218; c=relaxed/simple;
	bh=uJkG0r8LEbxpMkUXWKlBJh6geQ0o7Z8Y7m85WRlLX2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2Ba6DqFgBwCZnp3huCT1P8DnAPMLOtmvR/8Xi+urR2JVhxlbyE+quZZz5SV3xBab4TIlUrIUcnGF2yX9jgYo2vue93+IV/02Ij69bd3mSEHHX+g2QPwXooINwBuI3aM3IwwHEMFDL1dmGYCKJth9zgoMOVaajrQXODeSLlHzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkm3I9zc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkm3I9zc"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2db19761fso1155905a34.1
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929216; x=1708534016; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9l4eXEBkCeP4v7KENcvCRucSzGBpsjU86cA8gVWBlc=;
        b=gkm3I9zce8JT0guz6Zox1g0XGqZZ0aMP+OgHJxQKbQ4pJMj4JVMh9MOvd1wTp2g0fm
         9qOfggb5RAhbvzoAZuYF7nfPLw7W2h2V+8m3btAhrAVAMNakVsFGPFP1OuOjMN8P9pDF
         ZSMALWmrwr3AI3/UVb+aEVmQkuzlpYE2rQr+6yuk1b0m6a8Edz9rGxRkdqNO6dEC9b/0
         4bypRK3iutypqzu4VsouuSae0mQ5bYXal3kROj5fHz7MPSaXhBUvTz/bvZr90aEKKQ5W
         DUNzWOA8B3j+xTG43G7hk/vgO/RqW1wMMDJSC2qhpZXTeCMnNnnjYWmuUnJKI7nHhmik
         yObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929216; x=1708534016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9l4eXEBkCeP4v7KENcvCRucSzGBpsjU86cA8gVWBlc=;
        b=RPpP3eU1XQg+zgA8oHwmMAKRrXBXbDqUl/e27/4VTrKa2pLK9iP6t4IfEwR6+A+csJ
         yL0ZGL4Uv8xYxRuPd2F6e8PEB3+0cpJWIakFOD5f7iwmLyra4dzZXfr1h7lou7ZEFNbh
         rCOP683BtZDQGzqnT5uwU314o4BbKGydm5HgyaauxgXR9WDh/25gLHV17CqUAZ3zPKAR
         vsX8FTzXFGtUASbmoWNaTysz+HXTI3GtMph9Rd49vuhtEcOs1r05FXiwjabHveYGQMz9
         E2phwtIfl031WUChPiwFhWRpPNx1cwyzS7iMQfXAXv0NIWKRcuKD3KOcRwBSGq9Oil+P
         Vskw==
X-Forwarded-Encrypted: i=1; AJvYcCUKf3NYIxEV8DLj1wMh99Qp0uflOq3DolDXhlR1Wf1seOfbOgko0e48Mgca4thUiLKK4VzOae4EG0c1vYRfnikNHEhf
X-Gm-Message-State: AOJu0YwEsNOIh6JaTLHElnPNe7hptUKdui+OUOm7eBp6aIIddmhcOoUm
	fFhU2ILHhHe+qji2vXRDS72xYwUWQYAhsbXarBsF6ljJ1nzjuFP6
X-Google-Smtp-Source: AGHT+IHx1t9o5vL7IwAW1Whh2GiGDFq58FowbMsBzypXVw5MO+IEuVMJgsmale01dijvjcWRPmQ6ZA==
X-Received: by 2002:a05:6830:140a:b0:6e2:e13f:28c8 with SMTP id v10-20020a056830140a00b006e2e13f28c8mr3078801otp.28.1707929215785;
        Wed, 14 Feb 2024 08:46:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/Uqukftjy2GmcIjnspbhyAxZvahyW4E1gc3CDLdZImsN+EegacLSY/hohdGfi2BfPFy2q/6hAohYxX2TBVniF21SY
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v17-20020a05683018d100b006e2e679beb8sm844919ote.12.2024.02.14.08.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:46:55 -0800 (PST)
Message-ID: <a64273d2-e585-4e48-a35a-38384b79202c@gmail.com>
Date: Wed, 14 Feb 2024 10:46:54 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Clayton Craft <clayton@craftyguy.net>, iwd@lists.linux.dev
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
 <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
 <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 2/14/24 10:39, Marcel Holtmann wrote:
> Hi Denis,
> 
>>> Add a _get_driver is a good idea as well, but what is the reason for l_sysctl since sysctl is some specific system call.
>>
>> l_sysctl is used to write stuff into procfs or sysfs.  Naming comes from the sysctl(8) utility.
> 
> actually no. sysctl just handles /proc/sys/. It has nothing to do with sysfs.

You're right about sysctl.  ell used the same naming since it was meant to 
control net/ipv* kernel parameters.  However, the same API can be used inside 
sysfs since the semantics are identical.

If you don't like l_sysctl_get_driver, then lets call it l_sysfs_get_driver().

Regards,
-Denis
