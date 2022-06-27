Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374E17CB
	for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 16:37:14 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso10021650pjk.0
        for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=lt0dS4bepHR8xcpz+L4YirDN5JYpoJoLiskApZwJ8bA=;
        b=BB0f7N4j30XMjbITbPzD5pvdjVBn47QJJ/iwQNVnVwdYRnP5eogsKEYHffKQmh28al
         3jKiMhz+tzx7cXfhgGzzTUzp6oAKqXNd8l4cwIkEvWBpMaI+BWUTrY6h8mBfrGc8EvKv
         163QSLRGb3ajHn7DQ0C48omhiWWqA+8hw3UZRZnT/C1AkjJK57RTq+9jEMgTEJXxX1iX
         Q3Q74r9wUu8GeDVKd0bzhlmdqiM3o6fHpoztFDMOEnx1EK6ES9FzdEZWbYE9zDQlyycu
         6yBJAcX1OHT+y1FKGfqA4bFLh19/EHPoxDDS8/bzPvXzV2tuj1CsoDar+C++L7Q9V4XV
         U4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lt0dS4bepHR8xcpz+L4YirDN5JYpoJoLiskApZwJ8bA=;
        b=g+/yFu9E43387LbrHXlFqzSxTvhVx7vFGPLvJ4ixn9VrcE0OzkW7mbXakUEPbI4889
         40lnxBZ/tUos7koEUPtQgZxLrXkOfJW9VgYEtDBOsfmwU/yhDazqlsJUQQQaLQLjOKH6
         izrL2JIg0wb/pG/2dC4fHEg1+TT9UpNrhLtGcpIBS2WYwrd1c6eX20oBksytDc2I1OZ5
         wMv438v3TmUYCWcUn4liPKwSUpDEYgK/TCzpxgMW/lkWPJf55sWzJIXB/OFoKAuyVAAU
         XMEbINKxnG2tpSpP4QoF31Hr4AmIWgyET3CAJH47HASM0rsLZ6nes+8YUSvRzk2RCL8g
         Fb/A==
X-Gm-Message-State: AJIora9RJes3Gk8gArgwQAxvRbfmiEzHPyixANSyzpmufvOMeuQnoPE/
	HED470PWPfGx2czbOKUp6c8HcgZd/GA=
X-Google-Smtp-Source: AGRyM1t+Szh90IwDGoNSV4pORsPI9k17v8tof/rQip6qNx8OpjMEh6oYd8uidLsTfP1tB0CvPe4XoA==
X-Received: by 2002:a17:902:744c:b0:16a:1850:d055 with SMTP id e12-20020a170902744c00b0016a1850d055mr15344282plt.96.1656347834067;
        Mon, 27 Jun 2022 09:37:14 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090ad14700b001df4c5cab51sm7619041pjw.15.2022.06.27.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:37:13 -0700 (PDT)
Message-ID: <d45f1ddbf7086cbf14425ef1220a5ad40c1c53e1.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: Add new DeviceProvisioning API properties
From: James Prestwood <prestwoj@gmail.com>
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
Date: Mon, 27 Jun 2022 09:37:12 -0700
In-Reply-To: <20220624164346.254771-2-jesse@twosheds.org>
References: <20220624164346.254771-1-jesse@twosheds.org>
	 <20220624164346.254771-2-jesse@twosheds.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jesse,

On Fri, 2022-06-24 at 12:43 -0400, Jesse Lentz wrote:
> Document the Started, Role, and URI properties of the
> DeviceProvisioning
> API.
> ---
>  doc/device-provisioning-api.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/doc/device-provisioning-api.txt b/doc/device-
> provisioning-api.txt
> index 0aba2557..ac204f46 100644
> --- a/doc/device-provisioning-api.txt
> +++ b/doc/device-provisioning-api.txt
> @@ -56,3 +56,18 @@ Methods              string StartEnrollee()
>                                                 net.connman.iwd.NotCo
> nfigured
>                                                 net.connman.iwd.NotSu
> pported
>                                                 net.connman.iwd.Busy
> +
> +Properties     boolean Started [readonly]
> +
> +                       True if DPP is currently active.
> +
> +               string Role [readonly, optional]
> +
> +                       Indicates the DPP role. Possible values are
> "enrollee"
> +                       or "configurator". This property is only
> available when
> +                       Started is true.
> +
> +               string URI [readonly, optional]
> +
> +                       Indicates the DPP URI. This property is only
> available
> +                       when Started is true.

This looks good to me.

Just a note for next time, please send with a "v2" prefix. This lets
Patchwork remove old patch sets automatically.

Thanks,
James

