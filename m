Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA5D1B960
	for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751109; cv=none; b=MktEnXBtTMNhkTf1nexWPxmMI/k0r7jDrgIles5uhqqX0s8xUt4mFs0K+2q2YCtkqnGLTo0H8dPWOwcHdtvJvOnXfFwMuyCeRyS/RMJvrFgfMNzH+i1qlvw1Ek/7Ws2W42QDZPZ4XxS4M5OTQ37SHHd9A267+ql1LFX0TyVwou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751109; c=relaxed/simple;
	bh=Wo3erEW340BJOsMZJyHR/DAg7dzLcF7rFaXja1T/xqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kbJnNRrw8kbCcvoDw1tgeBRZHzOlpWbrIhheAtnIqYd6z3R//5UV0wIEnRsZRzJ+SZ1vZ18AMfZLs23JbkkzFJeRcH9eP6kcu2u7FBxbQCdgqe/HWUjJfLv7tOSfFFnDhmyFLf4GnhZR8ndF1BxHTWh5bP1fHc/BxVdJVSOOMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLjVWfFn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLjVWfFn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so4474435a91.0
        for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 05:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740751107; x=1741355907; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yr+y2xPjpkz5CGLWAbocnyd2mpr6DZqWAqi+/Bqv9BQ=;
        b=eLjVWfFnTIDUrEAE/NUCXh5O8rUBGRHjvFe56OBU58OSVEQZ4DUvAfTIZGeRFQm+P8
         fGe9Mhbz0+azoqJmEPoFeHR10nSIwLnABIsKAoItd7Qgbf2FIa7TL8ztAVFMlwdGE5gd
         /cSDcnfpX+7L84ssk7yTRHeWyxMrV7hyp7qZ6xXdsBj5sEL1qfNwrJPlnQI2NkUSQPc2
         4WB2gxAco/eNy2FKiCY3b2j8LB48JGApc8smGFo5h4bPxY/6UlCjjo/yVPaPrj787DHJ
         uU5QUymXbfTnS9iaQ7bsrcov7JaGhNkh4wngA4HAMcbfHFoip947W5500avYBg40o/Zl
         KcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751107; x=1741355907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr+y2xPjpkz5CGLWAbocnyd2mpr6DZqWAqi+/Bqv9BQ=;
        b=izp1vbP8JpsRCBffodHGQtNRq645CQg6LQVKQWEvKfUxexE3blOQD8pnRckmCeWBAw
         dYlfIY/EK6xwbw9iWmQ7MVJK8dKANTSJGwCxim8OaWmn7WVIMyEJjtnNEKy2HjZPCfZu
         HusmXrYulms1Lm8aiIFaLzLYxpqdPf07PNmJJmhcBs6J/2ozBO2U4LSQCtX2IHcDOCml
         xy5w9mJADHrgUFK19lMnnaoHN8Ac44BSWOGxIqI1fEURbC62s0HOe4mShJgpuqLe/y3w
         e4wK0C30qglLDywIvHmune6IKYdfSZ/SLoQMx9wVU6OEM2xu+BndD7gY4/7gNsbaDKig
         yg/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfEvtn0SLaDKg9zmQwNTyoBD8US+cBwJ6/diQEYMXI3ppCa1W9RSiqJk/F/QOeEIfbkts=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHmRGx/inHDo/ibixHjiRLizlgCQYJ+JCibdj3IwGfXkTSv230
	9xRSe0sBq5nKbJwIWB0ZAiXrmjiR02//RWgC6Ho3FMyIa4utdwtDCiuT3w==
X-Gm-Gg: ASbGnctJ78ZojA4EWt4RPj4O6ZWSOleQbqtt3ekrXed6ah9EMwmaV8P92aa4afQ0OJn
	tgRSXICuNCRZpPGQABwUh8aD2uDS6WDouUiqyZdpeRRgpH8L9iLusZIiwqwwEyUNqAMKBZyYntK
	WEQ1e8tnC84/cbUCHXqr5hDXy2K8R92GyjPV8YchnZxJxvYpPmV3vjpEO013x6eq81MujUFnO0o
	4vnF81ZYTUzHl98K6EkYkYs/1hdje3oR99ooYuKtuOgU+yOvIcP1Zq75db1/IVmAKqm7xR9R+8p
	cCGIOnnLaU2RiSaQEW4KGHfSEa2Wprys/5NdvwtRfVOxHvOdCwSW8e5YBTKG9ziru9/pCL6dlvh
	SVZzU
X-Google-Smtp-Source: AGHT+IHHEkUuQCqd8SlbE0FCiSkNzzkEJpjoQbD7LLXn3gjkxsWd3YhIUJCOIudetd3wzkHl+JYWew==
X-Received: by 2002:a05:6a21:692:b0:1ed:a5f2:dba6 with SMTP id adf61e73a8af0-1f2f3debf85mr5852284637.14.1740751107370;
        Fri, 28 Feb 2025 05:58:27 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de37e7asm2946759a12.40.2025.02.28.05.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 05:58:26 -0800 (PST)
Message-ID: <2c244463-921e-42bc-8618-aea86e28d075@gmail.com>
Date: Fri, 28 Feb 2025 05:58:26 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] netconfig: Global option to send hostname with dhcp request
 for all networks
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVS+UQfrbWFfsDnW1QvkpvmEnkxMdv+OPBy=XpPXEFdcU8Q@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVS+UQfrbWFfsDnW1QvkpvmEnkxMdv+OPBy=XpPXEFdcU8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 2/27/25 1:42 PM, Bryce Johnson wrote:
> Add global option to send hostname with dhcp always with
> [IPv4].SendHostnameAlways so the first DHCP request will include the
> hostname on first connection and don't need to modify the .psk files
> to add SendHostname after they are created.
>
> ---
> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> index 4ba7b4e7..4f473e07 100644
> --- a/src/iwd.config.rst
> +++ b/src/iwd.config.rst
> @@ -429,6 +429,11 @@ The group ``[IPv4]`` contains settings related to
> IPv4 network configuration.
>          will limit the number of access points that can be running
>          simultaneously on different interfaces.
>
> +   * - SendHostnameAlways
> +     - Values: true, **false**
> +
> +       Always send the hostname in the DHCP request for all networks.
NIT: You could probably just shorten this to "SendHostname". I 
personally don't mind if settings have the same name between main.conf 
and network profiles.
> +
>   DriverQuirks
>   ------------
>
> diff --git a/src/netconfig.c b/src/netconfig.c
> index cd19217c..5959a5ac 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -375,7 +375,9 @@ gateway:
>      }
>
>   send_hostname:
> -   if (l_settings_has_key(active_settings, "IPv4", "SendHostname") &&
> +   l_settings_get_bool(iwd_get_config(), "IPv4",
> "SendHostnameAlways", &send_hostname);
> +
> +   if (!send_hostname && l_settings_has_key(active_settings, "IPv4",
> "SendHostname") &&
>              !l_settings_get_bool(active_settings, "IPv4",
>                          "SendHostname",
>                          &send_hostname)) {
> @@ -391,13 +393,20 @@ send_hostname:
>          goto mdns;
>      }
>
> -   if (send_hostname &&
> -           !l_netconfig_set_hostname(netconfig->nc, hostname)) {
> -       l_error("netconfig: l_netconfig_set_hostname() failed");
> -       success = false;
> -       goto mdns;
> +   if (send_hostname) {
> +       if (!l_netconfig_set_hostname(netconfig->nc, hostname)) {
> +           l_error("netconfig: l_netconfig_set_hostname() failed");
> +           success = false;
> +       } else {
> +           l_debug("netconfig: Hostname '%s' will be sent in DHCP
> requests", hostname);
> +       }
> +   } else {
> +       l_debug("netconfig: No hostname will be sent in DHCP requests");
It probably seemed consistent, but l_error() actually doesn't include 
the file/function which is why those all have "netconfig:" in them. For 
debug prints we actually don't need to prefix with "netconfig:" since it 
will always include the file and function name.
>      }
>
> +   goto mdns;
> +
> +
>   mdns:
>      /* If the networks has this set take that over the global */
>      if (l_settings_has_key(active_settings, "Network", "MulticastDNS")) {
>
Thanks,

James

