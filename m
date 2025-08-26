Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AC1D61BC
	for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220208; cv=none; b=CtIJQHnuh2yxrYMyeLkx1zhKfeiNPrCxQrUXcU7iQFCXz4SRoZcNrtXu03+NC4GReED5uFSzj7MSG1d40Uqm4BNN3NExUmtF/1MbncFlIxGrHkj3FybPikrz4liDDn+M2w8hozT+rBsDNrI/B8T9VhVhwTjKCERv9hp/ya6trhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220208; c=relaxed/simple;
	bh=bUl+XsYEfuVIWxhximThXrw83ViQBRKdU2e+NAS13vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WeGYiN+7aQXeZ3HnaB8nXuHGrjw9W0gqqAAkXb7cJQKt7aCHkXlOPJGnEFSGUp0+VRObPzVy3Dyz5aMbnYQQmIx9XO/Op4CHhkGSWFgFZ9od0ASfP0wEf0YvKioi3RvsYdWfK3ntMxnyp0QQJzVlNH6xR6KIdzu2t7jQkrT9V8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX7FKgw5; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX7FKgw5"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61bd4e24ac7so2136843eaf.2
        for <iwd@lists.linux.dev>; Tue, 26 Aug 2025 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220205; x=1756825005; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YBrpPWPxgYAHrvBu5xbEQmMSHVXRXvYF+aHL5gN4LE=;
        b=mX7FKgw5IxOhUV8xWaNUVKvtN/qUgPW4bsx348xuhmTXgToOX1fQOdloxyxMKS6cOn
         vDifU3XfJL3NF9pxp/Bllt4S9u55w733gOwjxAbutwRryGbyNIg/zHY1/L4qpyUPt8+u
         WPWHvU516GAJufGapu69jEeiX355ABTNd4VJ0ywuggVl+zkzXuH7LLPpocAGbH4G0HgB
         2w3MLdgp9tYRfr2czt+psE8IWzZUqAfcLWmLlV66nP+ozInEJlIQzy+DpFKtMkCYq4sc
         pLAtqm+tm05bfp4+jHERBJhimQe3Y4w4JhAPRgetbHL0P65oL+hVOj0bxLLqs1YwyGMr
         /mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220205; x=1756825005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YBrpPWPxgYAHrvBu5xbEQmMSHVXRXvYF+aHL5gN4LE=;
        b=n9juEKIOhtP6w8ZkgS58AgX0lEgIwuZMBN7wRYBeFX49l/qw7pntTNkQzqb3bVuA3g
         fepGyOrKv/5ZIgKjpf7JDnEqKYGuC2MSRztt1Fhn5F7UdPtb+85PHrUyVv/RKCAGEOcq
         EIsEPdR4SepErWQhzZNM/HClrglr5iq+603SwPHYaaFqDXfK6bYMHr+UVCIKgRslftG9
         lyEV2Qx7DFTE3hxN3yR4PqXuA5NkHTdHOIUycVWaDn7IUxIcquzcQ19qopGc/O/KS1Ga
         ZwDxYJhfGcynk7VOTZje2CpwManwM8mKql9cv/OBm5MFKR9UJbab58/gyp5MYOedFlks
         rTiA==
X-Forwarded-Encrypted: i=1; AJvYcCUkUF3wbtng5UecihcKsIF7Rtv5lrx7i/u1CI1BDDMSQde+XBQNem8mHssAyT8qS62SRcw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxjnUlCYMto5JfxzCQc4FnBMoL7vV3bY9VX163Sc23aJCUhCt1X
	Adk9iu5BxNCSv0koEahPA9nstOs5gwZUcwVg80VFfTg5UWB8hmMD4Ynk
X-Gm-Gg: ASbGnctUjmMlRWAO/6a70xa6kup74URGxK4FFz/m/E8nZ9wEcYV75NeOcWF11bPYhuj
	6gxegF7PUMaRH7spVuWomP9F4zCW4lNRo2HBTjFkbvH8v0+wuiPaiJlJbsyG+VGfnDyVKl0qBtD
	wH8ySY8KXc1usFN0JUXJZbT0Hk6yQGRXy1W9VohO73yfbBjxG8E2viqoIDLmm4QtgVpg3fyWJ3W
	ODzLWc5AAbGP/ORllrzg3hv1ikI4gjYrScYmaY11LANsBkgpVNLy1EictrZV5AjDaKy94RLBgIs
	Tl5xVpltaTp3u2GDOXe7bUMBqcX7v+W3BegHByq1kmuaE94JY/kJKfBFwGcqWfaIxfxqqYpE3/4
	+3VuUuQJ8xo7jN1fxP2ZFjt4riW2osW5vfT03+uWw4fv+wzMI2pcL8qd1WJGM/b2MazIJ4tb1sH
	Y=
X-Google-Smtp-Source: AGHT+IEIDExoUjIUJjK6ISZqNn0Yn/LrpdCt1cQLdpiQsnPWe2P548BhHihZLnqud/DWHCKdAu2rhg==
X-Received: by 2002:a05:6820:1ac8:b0:61c:2bd:e0ab with SMTP id 006d021491bc7-61db9bab7d2mr8105552eaf.7.1756220205450;
        Tue, 26 Aug 2025 07:56:45 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-61dc786d005sm1403528eaf.17.2025.08.26.07.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:56:44 -0700 (PDT)
Message-ID: <65189e5b-3a3d-48ac-a814-31313d196654@gmail.com>
Date: Tue, 26 Aug 2025 09:56:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] vendor_quirks: initial skeleton
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-5-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250822195118.271122-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 2:51 PM, James Prestwood wrote:
> This module will provide a database for known issues or quirks with
> wireless vendors. For now the list of quirks is limited to 32 as
> that is the size returned in the bit mask. This could be extended
> to 64 in the future if needed, but of course the goal is to never
> reach that level.

You can always do something like:

struct vendor_quirks {
uint32_t behavior_a : 1;
uint32_t behavior_b : 1;
};

struct vendor_quirks vendor_quirks(const uint8_t *oui);

and just keep extending these as needed.  Let the compiler figure out how much 
space is actually needed.  Also makes the flags less verbose and more compact.

> 
> The vendor_quirks() API is intended to be called from scan.c when
> parsing vendor attributes. This will lookup any quirks associated
> with the OUI provided and a mask of quirks will be returned. This
> can be repeated against all the vendor OUI's seen in the scan. The
> result is then a bitmask containing all quirks for that BSS. This
> can then be referenced later during various operations in IWD.

Now, are you sure that just the oui is enough? What about mac address ranges or 
maybe IE contents?

Regards,
-Denis
