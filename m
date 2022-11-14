Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D14847C
	for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 20:03:22 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id t62so12546880oib.12
        for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 12:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSlBUHNeAeha+SOmvT33umGUMC+1Pg6rPE2pPNqjTpE=;
        b=MqOcS59fbtU3RaqRUQRhAv8DXJoe0c+a1FbMsWJ99MM8KxxdCwmd/ikK1OFeXUX6x+
         JrFfDAMv/1lkxIxPqOTqXzbDbj92nAmoQBb1kUYgWW5Xc0cAPf5tWWh1As4xkezGzyBd
         kr8UYfLDXANhTF0mhAjAHpv2R52uInVhBV7h3IF9qxG3oyUYE6WugOkW+W7T4dMR/0qH
         Yyc+BIwERZqjXfOSRtMaxDSfNPJtVrvRCQ2UVcWUTloTzh0ivYZayIxk81DF4Hog5EqQ
         Dm/h3dQY3pn9HhBrjcdlwxaI7xBeP/B3XdWeFABt5Qif7x1GABd9FwDcCo4AqwG1jRuA
         CVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSlBUHNeAeha+SOmvT33umGUMC+1Pg6rPE2pPNqjTpE=;
        b=MfBDd9t1ppYY/01gTyCbpoEuyxnd38gQD84XpLyKehShivG+HaGsOJ8909R8qwI4yu
         dcs3ymHNU/xaNTvHQAdgcci6tc+jRFHPLRtyVDkAvlSrUVuPeLSiOypPCeA4obg4tcS1
         833WAXHXwY4Fs3I5tkF31totWi3JmQlUeDtpx876/mIl/uoilQSNRuWuv/+LLKGeBwUQ
         MPlYU2LcwdDGpMTpHf4JG06iViZEjdfONXlENeG4KOAjmDBgDgit08HRSbEdVmTf3ug4
         5AVVHlElvQUzpOhToHp1wpOM0MaYMK+ANOYcMtSO9HNM+FUAOiqTc0eONbaxatR8KsgK
         QUqw==
X-Gm-Message-State: ANoB5pmX5suVLrzQIwxv7UO+7gVKCEg766BdWHOE/y4CblLQctEocEqI
	hj/wDfhwBmhRwnTdqK2uFhLwF3MYevs=
X-Google-Smtp-Source: AA0mqf5Z/pxnfM5mAqA6dg4iXjMWVL1GzS17QBHxG/9zYaREWhlHYBQgIPsT15k2pk7vVGnGym68Ng==
X-Received: by 2002:a05:6808:1294:b0:354:b300:16d5 with SMTP id a20-20020a056808129400b00354b30016d5mr6576857oiw.253.1668456201640;
        Mon, 14 Nov 2022 12:03:21 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l15-20020a05687014cf00b0013cd709659dsm5374547oab.52.2022.11.14.12.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:03:20 -0800 (PST)
Message-ID: <a9af6470-6363-5362-f81d-0d612ab851da@gmail.com>
Date: Mon, 14 Nov 2022 14:03:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] storage: Maintain the tls session cache object
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221112011929.785388-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221112011929.785388-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/11/22 19:19, Andrew Zaborowski wrote:
> Instead of only providing methods to load and save the TLS cache from/to
> file, keep the memory copy of the cache directly in storage.c since it
> doesn't fit anywhere else conceptually.  storage.c now only provides a
> getter for the cache object and the _sync method to be called by anyone
> who makes a change to the cache object.
> 

So overall I'm fine with this approach, just two quick things:

> While the use case is for eap-tls-common.c to call these, the same cache
> object could be used if l_tls is used in another part of IWD.  Any
> sessions saved in relation to a specific network (ESS) should use group
> names ending in the storage_get_network_file_path encoding of the
> network's SSID+security type, so that storage.c can automatically drop
> these cache entries if the network is being forgotten.

It seems overkill to encode the full path into the group name.  Perhaps a 
hex-encoded SSID is enough?

> 
> Since the cache object needs to be freed when exiting, use
> storage_exit() for that.  However, since there was already a
> storage_init() and storage_exit() pair of functions, with storage_init
> called from main.c conditionally on whether systemd encryption was
> enabled, rename that storage_init() to storage_key_init() and declare an
> IWD_MODULE to hanadle the calling of the new storage_init() and
> storage_exit().  There's no warranty that those will be called before
> and after any other module's init/exit but they're not necessary for any
> functionality that other modules depend on.

While what you have proposed here works fine, I do find it a little strange that 
storage_key_init() is being called before the modules were initialized (and thus 
storage_init() was called).  There's also a strange case where storage_exit() 
would not be called in case storage_key_init() failed, unlike the behavior now 
in $HEAD.

There seems to be no need for any of this at all since storage_init does 
nothing?  It might be easier to just let storage remain special (not a module) 
as it is now.

> ---
>   src/main.c    |  3 +-
>   src/storage.c | 92 ++++++++++++++++++++++++++++++++++++++++-----------
>   src/storage.h |  7 ++--
>   3 files changed, 77 insertions(+), 25 deletions(-)
> 

<snip>

> +static void storage_network_remove_tls_sessions(const char *path)
> +{
> +	_auto_(l_strv_free) char **groups = NULL;
> +	char **group;
> +	size_t group_len;
> +	size_t path_len;
> +	bool changed = false;
> +
> +	if (!tls_session_cache)
> +		return;
> +
> +	groups = l_settings_get_groups(tls_session_cache);
> +	path_len = strlen(path);
> +
> +	for (group = groups; *group; group++)
> +		if ((group_len = strlen(*group)) > path_len &&

Hmm, >= path_len?

> +				!memcmp(*group + group_len - path_len, path,
> +					path_len)) {
> +			l_settings_remove_group(tls_session_cache, *group);
> +			changed = true;
> +		}
> +
> +	if (changed)
> +		storage_tls_session_cache_sync();
> +}
> +

Regards,
-Denis
