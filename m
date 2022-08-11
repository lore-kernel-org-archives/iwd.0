Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA993222
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 14:39:25 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id bb16so21573184oib.11
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4l5cS1A+jbxgOqJeRWHKQ6FtovkkdQdRju4oY3LqSPY=;
        b=Cmh1S8HwPpOY8b/ielPLYXqLnpCf/cQkoJ6TVnaJmbKXbC+/AnBH2fwgJONxgw0Ego
         HSjSyIU+gl6WZm0dUkCTrc35AEruJkT63QMPZreEb8sqOQCQtpIHxCaf+5OsbG+if5lf
         Sh+fD8ZiVIQ8iLERB+D1IjlL7wSTB0d9bsbIO5xxFx2eYqfLhHkf1E99SXUYPYDOLH26
         BSi/nV6KFuQwY/b/a+Efc1P7heA6uGSg8Th5cFFuDqK8G3QwDheaMA+DIrhNg42VfhAD
         ia0zKz6SBGjlyU2N7vw0m8OQ7EkrYd9dbvZFkqTCZxqzw6rmO0G/q9msNTJKZPrVXJnb
         Ztsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4l5cS1A+jbxgOqJeRWHKQ6FtovkkdQdRju4oY3LqSPY=;
        b=FCexe5WWBNtJWxAcnChpzxlSc3UGniu7zbuHO8C3bssw3jTWRnv3HlqoAZ4n1lYTTD
         bcWe5QnRXn+JZCLxOqYZqOEutVLB14nszbOzxPBYPR+qSUI40abNeaEJkynHL5zo4izM
         YKkVU6CDamfIocXGhYf4I8yLxEFf9Kg6/cWXZebyZObYKwICMe8+r6utAoRyIl2lCrEK
         h7u5gSTmrzgSVtrRv9ffuu/ueyoNzQbiBMlSY1OMxrTaCjbkn9BkXvWTLZAxEBzdBF+z
         o5LGRQlUl5RqFF/VHxtTBHI91oFkKHSSBqOwVNShG7mgnAvPgF7XfgxhVHzGoZqsT3+E
         Ms5Q==
X-Gm-Message-State: ACgBeo2x3lVtZZV7Y/5UD5h1anwtrRfU9dTNNVwEt+M75DTTaF2Ti108
	GY9BGKfTdMJLUEk88+iWEaI=
X-Google-Smtp-Source: AA6agR4om16ERxBQhUlFvomceZmcsCqKFP+ZAi1tZHwOjUqu1+5Uo50XehPS62HWEFt1N7vmNXpvug==
X-Received: by 2002:a05:6808:220c:b0:342:eb79:5871 with SMTP id bd12-20020a056808220c00b00342eb795871mr3602326oib.54.1660228765113;
        Thu, 11 Aug 2022 07:39:25 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r5-20020a4aad05000000b00435a59fba01sm1117453oon.47.2022.08.11.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:39:24 -0700 (PDT)
Message-ID: <feae9344-ab84-e0c1-90e5-a652ad17bd47@gmail.com>
Date: Thu, 11 Aug 2022 09:39:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/8] station: add debug method GetNetworks
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220810231621.372514-1-prestwoj@gmail.com>
 <20220810231621.372514-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220810231621.372514-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/10/22 18:16, James Prestwood wrote:
> This gets all networks but includes individual entries for each
> BSS.
> ---
>   src/station.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 

You really should start with a commit in doc/ describing this API.

> +static void station_append_bss_list(struct l_dbus_message_builder *builder,
> +					const struct l_queue_entry *entry)
> +{
> +	for (; entry; entry = entry->next) {
> +		struct scan_bss *bss = entry->data;
> +		int32_t rssi = bss->signal_strength / 100;
> +
> +		l_dbus_message_builder_enter_array(builder, "{sv}");
> +
> +		dbus_append_dict_basic(builder, "Frequency", 'u',
> +						&bss->frequency);
> +		dbus_append_dict_basic(builder, "RSSI", 'i',
> +						&rssi);
> +		dbus_append_dict_basic(builder, "Rank", 'i', &bss->rank);

Rank is a uint16.

> +
> +		station_append_byte_array(builder, "Address", bss->addr, 6);

Are you sure you don't want Address in string form?

> +		station_append_byte_array(builder, "MDE", bss->mde, 3);
> +
> +		l_dbus_message_builder_leave_array(builder);
> +	}
> +}
> +
> +static struct l_dbus_message *station_debug_get_networks(struct l_dbus *dbus,
> +						struct l_dbus_message *message,
> +						void *user_data)
> +{
> +	struct station *station = user_data;
> +	struct l_dbus_message *reply =
> +				l_dbus_message_new_method_return(message);
> +	struct l_dbus_message_builder *builder =
> +				l_dbus_message_builder_new(reply);
> +	const struct l_queue_entry *entry;
> +
> +	l_dbus_message_builder_enter_array(builder, "{sv}");
> +
> +	for (entry = l_queue_get_entries(station->networks_sorted); entry;
> +							entry = entry->next) {
> +		const struct network *network = entry->data;
> +
> +		l_dbus_message_builder_enter_dict(builder, "sv");
> +		l_dbus_message_builder_append_basic(builder, 's',
> +						network_get_ssid(network));

Using the SSID as the key is not a good idea.  You can have multiple network 
types with the same SSID.  This should probably just be an array of some sort. 
Or maybe a dict where the key is the .Network object path.  Something like 
a(oa{sv}) or a{oa{sv}}.

> +		l_dbus_message_builder_enter_variant(builder, "aa{sv}");
> +		l_dbus_message_builder_enter_array(builder, "a{sv}");
> +
> +		station_append_bss_list(builder,
> +					network_bss_list_get_entries(network));
> +
> +		l_dbus_message_builder_leave_array(builder);
> +		l_dbus_message_builder_leave_variant(builder);
> +		l_dbus_message_builder_leave_dict(builder);
> +	}
> +
> +	/* Hidden Networks. Use an empty string for the SSID */
> +	l_dbus_message_builder_enter_dict(builder, "sv");
> +	l_dbus_message_builder_append_basic(builder, 's', "");
> +	l_dbus_message_builder_enter_variant(builder, "aa{sv}");
> +	l_dbus_message_builder_enter_array(builder, "a{sv}");
> +	station_append_bss_list(builder,
> +			l_queue_get_entries(station->hidden_bss_list_sorted));
> +	l_dbus_message_builder_leave_array(builder);
> +	l_dbus_message_builder_leave_variant(builder);
> +	l_dbus_message_builder_leave_dict(builder);
> +
> +	l_dbus_message_builder_leave_array(builder);
> +
> +	l_dbus_message_builder_finalize(builder);
> +	l_dbus_message_builder_destroy(builder);
> +
> +	return reply;
> +}
> +
>   static void station_setup_debug_interface(
>   					struct l_dbus_interface *interface)
>   {

Regards,
-Denis
