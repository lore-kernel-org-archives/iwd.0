Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D27461
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 18:59:35 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2765308pji.0
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZDviH/ckmoO5w+IOEXC4ehBoyXyN4K15igSSfif/J8=;
        b=iCA0GT/z7cPoeZ7oMJEX8J71Z1chJiX8BwoWzoz42pJoy5jpKpPhrPNCIbW8b8w+0b
         mV1SD7NGJINQmphLGnvkiyX5oHT7DchKi0xALqw3cBO3/05LkfQyjOOz9RHmh9EqKXZw
         05fc8FAVaPRV4NK5xA0lT5eCUr53Uy+5s/Vc9ccGgbtRpJ0Rsm6gD0Fa811xbuI468Xt
         tqJBv820OdqEcDgP38+SZVEV16lt/MaxC//byvC94lqChN+t5MdzLqCh8fNYAx9mbI7Y
         lZ5MYb+tw7yCp7mtlYC4n0goCjEaXtJB5WsmZkEm8jcMQMAWq7DOe5C3yc4+jQ7FMwMD
         8mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZDviH/ckmoO5w+IOEXC4ehBoyXyN4K15igSSfif/J8=;
        b=3Bf1cF+Q37C8RXW1nAvGRgy9pt2F54zfPOnwScpgs5y0fJbsuKMSkbxYSelF2Pt062
         +II5QeM2rLsMMpZzXhzU0EWTpA19mUYjsjFMNsO3lPrehEMRgFxk27kea7/JeNxDUhAX
         DSrR34YlyYbfdky1Xk413E+KzanOldxgWgx3r1JyzybL2lw+3pBt55wBjcaRUb4WO/p0
         F53w64PE63m0vMHUiZ3XsbhoI3Tul9zTB8ILbl1LZ8yMsqxd2aUoWPRfAajvGcx/J8Y4
         hxaHrKt6SeH/cdD/UoP4KI3mlP7MtS6lvF0y8vaGaC68NxKoajfU6nGIbXENya0iRolr
         oDVw==
X-Gm-Message-State: ACrzQf0mR5xTnPSycihWPMNIcsO8WgttwbVenV83V5P22KqZlhB07pjR
	iUY0FUv0hSapXbkM/V4b0AcFep8to34=
X-Google-Smtp-Source: AMsMyM4p/9ssj5RN0tCcR4YRjHoJREKv3uI64gVV0DHywtvtUYWhdHafDlEgMJ0egwN5IYRYs/Ha6A==
X-Received: by 2002:a17:902:c2c4:b0:187:640:205c with SMTP id c4-20020a170902c2c400b001870640205cmr24825507pla.11.1667415575045;
        Wed, 02 Nov 2022 11:59:35 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 41-20020a17090a0fac00b0020aacde1964sm1788828pjz.32.2022.11.02.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:59:34 -0700 (PDT)
Message-ID: <df5432b7b11b385bd58e0c7a96bf2f7fb842c75b.camel@gmail.com>
Subject: Re: [PATCH 1/2] client: fix spurious newlines in station show
From: James Prestwood <prestwoj@gmail.com>
To: eNV25 <env252525@gmail.com>, iwd@lists.linux.dev
Date: Wed, 02 Nov 2022 11:59:33 -0700
In-Reply-To: <20221102092156.71357-1-env252525@gmail.com>
References: <20221102092156.71357-1-env252525@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2022-11-02 at 14:51 +0530, eNV25 wrote:
> This change removes duplicated calls to display_table_footer(), in
> station show.
> 
> Before this change, the bug caused an extra newline to be output
> every
> time the table updated. This only occurred when the network was
> disconnected.
> 
>     $ iwctl
>     [iwd]# station wlan0 show
> 
> ---
>  client/station.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/client/station.c b/client/station.c
> index b070807b..1d958ef2 100644
> --- a/client/station.c
> +++ b/client/station.c
> @@ -217,15 +217,9 @@ static void display_station(const char
> *device_name,
>                         47, network_get_name(station-
> >connected_network));
>  
>                 display_addresses(device_name);
> -
> -               /*
> -                * If connected the diagnostic interface is
> presumably up so
> -                * don't add the table footer just yet.
> -                */
> -               return;
>         }
>  
> -       display_table_footer();
> +       /* The table footer is handled by cmd_show. */
>  }
>  
>  static void display_station_inline(const char *margin, const void
> *data)

LGTM, I noticed this happening but never spent the time to diagnose it.
Thanks!


