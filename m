Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39386342529
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787921; cv=none; b=nhF5x6uhmehHE3YJNZxuB6Qjc6h3SJa5SBia+Prf4hpY1CvdZ6SZu9Vp9+cgUlphwHfl94Sfb0US+XPu/uQBqcH5pod2bEsooCGxMNT+1yTOioJMFcXVbEPiJUQbk0/00hGu97im/MK9ZRUZ5HbOfQOfJq3apgCS/NMQTD8Eawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787921; c=relaxed/simple;
	bh=wXegCcLEXDDLqSV1G6n3e9ew5Tl594KJcR6ek6/KuOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VuRtigPZ5XKATe+gYyG5uXcbuPP9hsj0NkjcEZMGlwf13Ti2/ew1QHas+EZfHpmBrEomdIu+wcfXhy2eeiv+hsOXW6xADQAk+sVH0rS92kpeZeJ1VdsLuUy9PLjLcF5ZtF9wyh9CgYXcEpKtmOxbvc/2M03CFeXojJwBgNLMaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni4ZYPKJ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni4ZYPKJ"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1866473b0so1416274a34.1
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 07:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769787919; x=1770392719; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JEzG+1G3XEkLEruElOnbqO3QUNNc272TQzlFazsWJeo=;
        b=ni4ZYPKJ42dtAtCCO1gWmbN+6lbfm+HEh8gYVMDNdsu7/Xj/YLehbzoghajG+K42yu
         2cuY9o2/etvbiAnR1Bom5SAc0b3FGgaUyCFXkbOjzD5wZXMXgOBSRZgCF8ep+viGakZL
         dWwiYAjmAVhLJO92puge0A4qX/dx+hhc5AIKqtqIvgxOSXVoChmFCuJ3lkq8DzDuk2Gl
         n/Ex+qDFh5FQLWZTZmRH6lSI4+kYbMZOwsMUyNdxxsdK+EpTWAfI+3eV0yuWleCo3GIr
         MvluD57eZLub150BzgsNudV4v3O5rjnzD128S6X5kPzhKcndiYPZ2D6qzQ95gccp4M/A
         GLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769787919; x=1770392719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEzG+1G3XEkLEruElOnbqO3QUNNc272TQzlFazsWJeo=;
        b=fNQm6DMxxRiip4gpy03wgXnVVFNVpWQUBxcceaALEdSrPCANzmM9gL3ykdsoRwoXeG
         cLDvQF6jt/VSlhFs3JstIjeBJvClZHgAgJ22FE6u31B6Jtag/ywbwgZEwtTq9CpaFJLw
         3otmwq6ne3zl/woOd4b8y+1GGzzdsGVvxnRVQ8nHogT78wo/NSlfpwmdh2/4WHMOI1Pd
         Fc2L7xPHnt7mqaQdhMU7ylUm+l/FNbcZvpkvNRpJGe22Bsah8ewWK333e5RmsYgOGePd
         RKSHkXRV8QwBhfmby3hSX4UKC2RWNzFVY9zwVmecpOQ4pmCBPWw4TNMsBWvLyK/yuM2+
         z6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUDnwhndJ9MmYomuVb4CF6GWsxMSspNNNh0b/DwQWsAQgi7aFXOF8Roq59JPS4sK4Y8/sc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOZQLDLVqqVtZAwnNyPNfEQ7QbtH+q+ltMLp4DerbNgtTZPa2m
	jn3Dnd45v4luo+0qEy1FQOFoP6NxVE6n/sBnMEZfCLhsXPrCuU/FktsCMNm8Dg==
X-Gm-Gg: AZuq6aIYbpKpYQaBwuu8oEFIhkVegtirUPelBZ/OHkx4ovRBKFdVj4Wymd7cGmM8VbP
	y+Vdzai6tGppJdWY3emJs2wSenQ5gpBUjrfUih49cwg7Odno9qW0CWHSFvnNaNf9xqgVHyGFB2z
	j3AshR8MK2eBifkghyxUI2qGfcDEec+m2FH9/ehoGg8fBL+9Scecd3igaMyIPFogxBeKYhdMHD4
	tSDPzJd/QwssKq391ATKLFcdBZFDop80H5BjIh9lR1vVI2dx5z6j8UZR7Ry2XyfFe/yxy1Z08zf
	MIS+4qhgN0ZHpcdPnOve+7+ZTFMGD8Ntq/aQeExbm6o3L9IqMWugpTjOJBBi9k57qAHkhhhwRW3
	Mxnfq772DtA9lAyqUND4PTuCx9WtCas0rvG8pA2TSoRSmlGtT2Fw/Mugg3bJ2xNMrEuBIZa6nof
	yBqkWXGnogrH8bOBq9g/wB
X-Received: by 2002:a05:6830:6aaa:b0:7cf:ddb7:8823 with SMTP id 46e09a7af769-7d1a52624e0mr2461781a34.11.1769787918928;
        Fri, 30 Jan 2026 07:45:18 -0800 (PST)
Received: from [172.16.49.130] ([70.112.199.191])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d18c6708e1sm5785646a34.5.2026.01.30.07.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:45:18 -0800 (PST)
Message-ID: <35652eba-2aa9-4b6e-8bcd-a742fde28645@gmail.com>
Date: Fri, 30 Jan 2026 09:45:17 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dbus: register interface before acquiring name
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <20260127224325.86027-3-ronan@rjp.ie>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20260127224325.86027-3-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ronan,

On 1/27/26 4:40 PM, Ronan Pigott wrote:
> If the interface isn't available by the time we acquire the well-known
> name, clients can get confused when the expected interfaces are missing
> during bus activation.
> ---
> This code seems backwards to me. Presently, if IWD is not running,
> calling any IWD methods will fail:
> 
>    $ busctl call net.connman.iwd /net/connman/iwd net.connman.iwd.Daemon GetInfo
>    Call failed: No matching method found
> 
> only to succeed immediately after once the bus activation is complete:
> 
>    $ busctl call net.connman.iwd /net/connman/iwd net.connman.iwd.Daemon GetInfo
>    a{sv} 3 "NetworkConfigurationEnabled" b false "StateDirectory" s "/var/lib/iwd" "Version" s "3.10"
> 
> With this patch, we register IWD methods before acquiring the well-known
> name, and the abovve call succeeds on the first try.
> 
>   src/main.c | 46 +++++++++++++++++++++-------------------------
>   1 file changed, 21 insertions(+), 25 deletions(-)
> 

<snip>

> @@ -249,12 +228,29 @@ static void dbus_ready(void *user_data)
>   {
>   	struct l_dbus *dbus = user_data;
>   
> -	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
> -				request_name_callback, NULL);
> -
>   	l_dbus_register_interface(dbus, IWD_DAEMON_INTERFACE,
>   					iwd_setup_deamon_interface,
>   					NULL, false);
> +
> +	if (!l_dbus_object_manager_enable(dbus, "/"))
> +		l_warn("Unable to register the ObjectManager");
> +
> +	if (!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
> +						IWD_DAEMON_INTERFACE,
> +						NULL) ||
> +			!l_dbus_object_add_interface(dbus, IWD_BASE_PATH,
> +						L_DBUS_INTERFACE_PROPERTIES,
> +						NULL))
> +		l_info("Unable to add %s and/or %s at %s",
> +			IWD_DAEMON_INTERFACE, L_DBUS_INTERFACE_PROPERTIES,
> +			IWD_BASE_PATH);
> +
> +	/* TODO: Always request nl80211 for now, ignoring auto-loading */
> +	l_genl_request_family(genl, NL80211_GENL_NAME, nl80211_appeared,
> +				NULL, NULL);

nit: I would preserve some of the original behavior and not request the NL80211 
family until we know that the DBus name request succeeded.  If we can't jump on 
the bus, we can't manage NL80211, so having the subsystem loaded, etc is wasteful.

> +
> +	l_dbus_name_acquire(dbus, "net.connman.iwd", false, false, false,
> +				request_name_callback, NULL);
>   }

Otherwise, looks reasonable.

>   
>   static void dbus_disconnected(void *user_data)

Regards,
-Denis
