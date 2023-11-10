Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7410F2
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI+Biuuo"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1f084cb8b54so932508fac.1
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 18:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699582944; x=1700187744; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btNFqeqgI/zaJUijmCwBaLP0Mf2URH/yS8fIvyFToUU=;
        b=BI+Biuuo7h6yhe+5AEz3faNCBls0Vd2OweSAdV88tQuIkIq2LGakrhlKAtD9PmIgD7
         GdE6+2CGFqZUUB7CzaONJY+piB77U+kAsAY3WPehQH6z4+SLkSNUQSahgt/wzUvJDRvy
         RMDODWw2Fr8lasbxgJYnqSif91dsVGCqaaEJwsfyE0gtcqDcSWRnMpoN4PzXTuuiHS67
         n4QJEpDlelcRXS6PXaGbY4IgfvAtm3Ny51AZjwk/TMTttK/vkzG61WXu/R6La6U2vshR
         H1ux+jHUzeetPKAGhGMmnhfY16ZwNMkUwOBvYyVUlyFkZcepUGVIsDh+EgvO6dR/PmHh
         2obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582944; x=1700187744;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btNFqeqgI/zaJUijmCwBaLP0Mf2URH/yS8fIvyFToUU=;
        b=vagCaHzbCHA/9E3MBffHvDG39isJiXWB2WEKDU6MfQylmlLGLkgUiHi9h3mwD+f6Fu
         4vMOXBPuMWtrogu875zyv61dHozdRkXT9BabzAN9Ruu0kK6W5dZv7BRsfJO8JNzJ/jYZ
         4Np9jndw1xGExA24f6Cs661+Qpu7pz2UGHA6sZ1tBravQ6gw8Tdj7hbksS36U0StzMrj
         o7/TN6M5NhJvtN8HdXgV+LTq06sDWIq8EyprtE4+tk1EeIwmhWWFLwr+2UdIfjgQ9wH1
         Sa5iyHdl5LuRc0jImY6i9nOEVibfjQSfROtiXzZmIoEbYRhvxzUPfBcNvuzmNxBDbJvF
         8icA==
X-Gm-Message-State: AOJu0YzFv8FZmN25m4GwprSd+oynknG+rn67AL+NPYGaYMJhhVYp7AHp
	/jod7joRRrD7AibYxHtP1Ok=
X-Google-Smtp-Source: AGHT+IG5pzY/q7pPDMYVxOUUxGe7xsk2PABamGL317UIPL6nv7Dh/BzYvL9kEjX1/OGNhckqpLE06w==
X-Received: by 2002:a05:6871:a9c3:b0:1ea:ce71:dd12 with SMTP id wp3-20020a056871a9c300b001eace71dd12mr7085336oab.3.1699582943770;
        Thu, 09 Nov 2023 18:22:23 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id du44-20020a0568703a2c00b001eace5491c8sm938234oab.18.2023.11.09.18.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:22:23 -0800 (PST)
Message-ID: <8963c077-984f-474d-afec-5e02ef8182e3@gmail.com>
Date: Thu, 9 Nov 2023 20:22:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] client: add helper to call method via builder
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231109184926.52629-1-prestwoj@gmail.com>
 <20231109184926.52629-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231109184926.52629-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/9/23 12:49, James Prestwood wrote:
> There was no way to call a method with anything except basic
> arguments. Add a helper to use a builder to create more complex
> args.
> ---
>   client/dbus-proxy.c | 36 +++++++++++++++++++++++++++++++++++-
>   client/dbus-proxy.h |  9 +++++++++
>   2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
> index 42b8427f..de252427 100644
> --- a/client/dbus-proxy.c
> +++ b/client/dbus-proxy.c
> @@ -2,7 +2,7 @@
>    *
>    *  Wireless daemon for Linux
>    *
> - *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2017-2023  Intel Corporation. All rights reserved.

Is this correct?

>    *
>    *  This library is free software; you can redistribute it and/or
>    *  modify it under the terms of the GNU Lesser General Public
> @@ -629,6 +629,40 @@ bool proxy_interface_method_call(const struct proxy_interface *proxy,
>   	return true;
>   }
>   
> +struct l_dbus_message_builder *proxy_interface_new_builder(
> +				const struct proxy_interface *proxy,
> +				const char *name)
> +{
> +	struct l_dbus_message *call = l_dbus_message_new_method_call(dbus,
> +						IWD_SERVICE, proxy->path,
> +						proxy->type->interface, name);
> +
> +	return l_dbus_message_builder_new(call);

Do you really need this 2 line function for a single call site?

> +}
> +
> +bool proxy_interface_method_call_from_builder(
> +					const struct proxy_interface *proxy,
> +					struct l_dbus_message_builder *builder,
> +					l_dbus_message_func_t callback)
> +{
> +	struct proxy_callback_data *callback_data;
> +	struct l_dbus_message *call;
> +
> +	if (!proxy || !builder)
> +		return false;
> +
> +	call = l_dbus_message_builder_finalize(builder);
> +
> +	callback_data = l_new(struct proxy_callback_data, 1);
> +	callback_data->callback = callback;
> +	callback_data->user_data = (void *) proxy;
> +
> +	l_dbus_send_with_reply(dbus, call, proxy_callback, callback_data,
> +									l_free);
> +
> +	return true;
> +}
> +
>   void *proxy_interface_get_data(const struct proxy_interface *proxy)
>   {
>   	return proxy->data;

Regards,
-Denis

