Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23F185A
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzpYVkVt"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b58d96a3bbso861597b6e.1
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 18:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699583516; x=1700188316; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/P2VPT1Q4/AhcKsa/sG6/ZnhTr6vmoECoXiSjhnQqdM=;
        b=CzpYVkVtg5nIBsYGsUzL25umHS6Dt2j9Jk/NeZyz3NUPk2zoSJLCDxau0oXvRPUWow
         7aEHinMjZ9/CNWGQKtQhEcDDpaRGw41qgV0nGUeLjl2PL+vY9HF5Evi9KTigN4vZOKog
         7w7cjmpdAnjLxNEqTurzE4j5WYaOFT/BEbFxJHoFJgBOnC43ZArkg/NKMdf0jMnGuBmw
         Fj0aOV4TNyPAnty0GxV6/x32ME3YMTtxETo/rZQtCzWAFvy/IPa9HLkEtHSPSqgFZP6r
         ZN43ydEMUNWEyPW91c+dexYLGaHS/bxY+G9wHUF5OeaTDCPb4WZ7kteIkkXU7hFGYenx
         Y51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583516; x=1700188316;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/P2VPT1Q4/AhcKsa/sG6/ZnhTr6vmoECoXiSjhnQqdM=;
        b=Yanu3D74tL7GhF4ffU1RQDYfhA6jRC2tEXWyyB0ntBc/nlv3/cZlCQwLqo1livu2Ur
         3h21/xoVdqNIAdURhJSz66RfaiyhsKM+xXpN+fD0bmDzLVgWPH6cY43UpgC/I8fWT8Qm
         2HssOxWpahwJl/NWJE5YuVygPU6nFTiN9nvRmZ4G0t0KdKAq/fZBSQXXum4IOmzDP84N
         f82dxhkuo7sSvsF9aG59lNAw6I6PDxT+DY50ubJnFDkOftv3+QT1WzUJPa2h3G2vAQSg
         k6RCkEd4Nfr2imgBAAfr/MaBMadRTAGQPYyFaCrlAdBU4J1P4MYttjSgzeTJBuUoCD6j
         5MDQ==
X-Gm-Message-State: AOJu0YyBd0Io32P7HP7ml0OuUO8XSCQSkkhJaFwTP+8QJ9yhx2vz8NVT
	jZIotkx9Jj5jyhP9OFmtDMgoT74QASQ=
X-Google-Smtp-Source: AGHT+IEza2mWq0sabIUviQE60iLzauSf7am1WKZTsn60zrBlff+Gh+mZa5ivBENXoc4dVrrx7i5S8Q==
X-Received: by 2002:aca:2414:0:b0:3b2:e33c:ce27 with SMTP id n20-20020aca2414000000b003b2e33cce27mr3138416oic.2.1699583516565;
        Thu, 09 Nov 2023 18:31:56 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m1-20020a0568080f0100b003af5d7d9f3bsm206416oiw.4.2023.11.09.18.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:31:56 -0800 (PST)
Message-ID: <0df290a1-50ba-4906-b4ae-be2d4b2675be@gmail.com>
Date: Thu, 9 Nov 2023 20:31:55 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] client: add client commands for shared code
 configuration
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231109184926.52629-1-prestwoj@gmail.com>
 <20231109184926.52629-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231109184926.52629-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/9/23 12:49, James Prestwood wrote:
> The StartConfigurator() call was left out since there would be no
> functional difference to the user in iwctl. Its expected that
> human users of the shared code API provide the code/id ahead of
> time, i.e. use ConfigureEnrollee/StartEnrollee.
> ---
>   Makefile.am       |   3 +-
>   client/dpp-pkex.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 344 insertions(+), 1 deletion(-)
>   create mode 100644 client/dpp-pkex.c
> 

<snip>

> diff --git a/client/dpp-pkex.c b/client/dpp-pkex.c
> new file mode 100644
> index 00000000..7a6934e1
> --- /dev/null
> +++ b/client/dpp-pkex.c
> @@ -0,0 +1,342 @@
> +/*
> + *
> + *  Wireless daemon for Linux
> + *
> + *  Copyright (C) 2023  Intel Corporation. All rights reserved.
> + *

This looks incorrect.  Copy-paste?

> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
<snip>

> +static enum cmd_status cmd_enroll_or_configure(const char *device_name,
> +						char **argv, int argc,
> +						const char *method)
> +{
> +	struct l_dbus_message_builder *builder;
> +	const struct proxy_interface *pkex;
> +	const char *key;
> +	const char *id = NULL;
> +
> +	pkex = device_proxy_find(device_name, IWD_DPP_PKEX_INTERFACE);
> +	if (!pkex) {
> +		display("No pkex pkex on device: '%s'\n", device_name);
> +		return CMD_STATUS_INVALID_VALUE;
> +	}
> +
> +	if (argc < 1)
> +		return CMD_STATUS_INVALID_ARGS;
> +
> +	key = argv[0];
> +
> +	if (argc > 1)
> +		id = argv[1];
> +
> +	builder = proxy_interface_new_builder(pkex, method);
> +
> +	l_dbus_message_builder_enter_array(builder, "{sv}");
> +
> +	append_dict_basic(builder, "Code", 's', key);
> +
> +	if (id)
> +		append_dict_basic(builder, "Identifier", 's', id);
> +
> +	l_dbus_message_builder_leave_array(builder);

This can all be done as:

l_dbus_message_set_arguments(msg, "a{sv}", 2,
				"Code", "s", key,
				"Identifier", "s", id);

> +
> +	proxy_interface_method_call_from_builder(pkex, builder,
> +						check_errors_method_callback);
> +	l_dbus_message_builder_destroy(builder);
> +
> +	return CMD_STATUS_TRIGGERED;
> +}
> +

Regards,
-Denis
