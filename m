Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEABE5B
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzdEvixy"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c49f781855so4520524a34.3
        for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697638819; x=1698243619; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drMkCBRaXI+VUaksngL3GWKeZcO6TcZ2+QGeaRkFRhQ=;
        b=kzdEvixy6WnKop49+fGFRN4qLOFPCi3ChvldT14+X7PoGBXS+LbYrNjZoOVVPnRhnj
         yQETwRPggcf/wiaKom3TCGcaDalT7IbyZJiwk9lygYUyQa0UrP8QeLVL0IweLltiT+Gw
         IZVwqW0T+lq3ZuVj8pql1mzbEjxw9hJ49LifW+tIIJtEkhdQIYnGg61032FT2QwE5b0x
         wZtoCILECF2ByVESTHnEfnzQkjf5rQmXR8DPRmdof49pfiaKwCUJi5pdtN8CwnrpODFM
         oO/otbTAw9PHXI3OBxmQejc5mfTYSLz9siIrxmwCn6uVa0CLUyfNEqowIsahS+67UsZp
         QUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638819; x=1698243619;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drMkCBRaXI+VUaksngL3GWKeZcO6TcZ2+QGeaRkFRhQ=;
        b=bbX4oFwRL756KobOGfSzf4BjdT8pgbj1bgvMgRmIJqihYOsvimJHJYFRQKWhAeAjgC
         67uCfndQUKrOrsCyDMAa1QMOGPe3Cwp0vF5ePUQEZP+0f6onebtaBolzHp8FJCs5WV7N
         goFZpeJMasNUzy5DIiUXE4E7FNOZuSdGHHaXNAemSFLcPc+UTsSvFuIHSbgunhQM5Y+8
         ClMT8KRgKQVzIQtrb87XT70vpSHKCOptMfKtz4+UMtgw/wLAmRwPZtdyXb66Uyx9YQd1
         4Hq4rnll9Qq0eAi1jAw2WuumBeK+sFgCQeA3deGR8Y9glXU3/GFSJuikla72tyz+ZljL
         E24g==
X-Gm-Message-State: AOJu0YxGVaUl4jA8xigl93DMZNM7op61fgKLNf6DXhuUxMH6v4vBvjVX
	zE7IyRI4GvNiOFjw0DjcZ9w=
X-Google-Smtp-Source: AGHT+IHHMy5d2SvCxbVgAU4b7qQIcIjjOEPUFY4unplJyqL2vs5rqkxql1MMeiW2sCuT7wNQmkbbPA==
X-Received: by 2002:a9d:4d17:0:b0:6cd:9b6:5954 with SMTP id n23-20020a9d4d17000000b006cd09b65954mr978298otf.38.1697638819599;
        Wed, 18 Oct 2023 07:20:19 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l24-20020a9d7a98000000b006cd0a56c406sm104585otn.60.2023.10.18.07.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:20:18 -0700 (PDT)
Message-ID: <cd9a73d3-8ed9-4c76-b44c-4c8af6250977@gmail.com>
Date: Wed, 18 Oct 2023 09:20:17 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add AllowRoaming station property
Content-Language: en-US
To: =?UTF-8?Q?Pedro_Andr=C3=A9?= <PEDA@bang-olufsen.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231018122534.33455-1-peda@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231018122534.33455-1-peda@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 10/18/23 07:27, Pedro André wrote:
> From: Pedro Andre <peda@bang-olufsen.dk>
> 
> This adds an AllowRoaming property to the station struct that makes it
> possible to indicate to the station/interface that it should not go
> into roaming state (when set to false). This property defaults to true
> (i.e. it defaults to the normal iwd behaviour that allows roaming).
> 

Is it possible for you to share the actual use case for this?  It would help to 
understand what problem this is trying to solve.  One problem I see here is that 
we might still want to honor AP directed roaming.

> ---
>   src/station.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 

<snip>

> +static struct l_dbus_message *station_property_set_allow_roaming(
> +					struct l_dbus *dbus,
> +					struct l_dbus_message *message,
> +					struct l_dbus_message_iter *new_value,
> +					l_dbus_property_complete_cb_t complete,
> +					void *user_data)
> +{
> +	struct station *station = user_data;
> +	bool roaming;
> +
> +	if (!l_dbus_message_iter_get_variant(new_value, "b", &roaming))
> +		return dbus_error_invalid_args(message);
> +
> +	l_debug("Setting allow_roaming %s", roaming ? "true" : "false");
> +
> +	station->allow_roaming = roaming;

So what happens if we're in the middle of a roam?

Also, what happens if this is reset to true and our rssi is already below the 
roam threshold?

> +
> +	return l_dbus_message_new_method_return(message);
> +}
> +
>   void station_foreach(station_foreach_func_t func, void *user_data)
>   {
>   	const struct l_queue_entry *entry;

<snip>

> @@ -4484,6 +4522,8 @@ static void station_setup_interface(struct l_dbus_interface *interface)
>   					station_property_get_scanning, NULL);
>   	l_dbus_interface_property(interface, "State", 0, "s",
>   					station_property_get_state, NULL);
> +	l_dbus_interface_property(interface, "AllowRoaming", 0, "b",
> +				station_property_get_allow_roaming, station_property_set_allow_roaming);

doc/coding-style.txt, Section 'Background', paragraph 2.

Also, there's missing documentation for this property.  And it seems to overlap 
rather significantly with "DisableRoamingScan" setting.  What's the plan there? 
And since we're adding a new API, can we at least add an auto test?

Regards,
-Denis
