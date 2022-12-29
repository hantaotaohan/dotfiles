local present, code_runner = pcall(require, "code_runner")

if not present then
    return
end

local options = {

    mode = 'toggleterm',
    focus = true,
    startinsert = false,

    term = {
        position = "bot",
        size = 8,
    },

    float = {
        border = "none",
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
        border_hl = "FloatBorder",
        float_hl = "Normal",
        blend = 0,
    },

    -- filetype_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/code_runner.nvim/lua/code_runner/code_runner.json",

    filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        python = "python3 -u",
        bash = "bash $fileName",
        typescript = "deno run",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
    },

    project = {
        ["~/desktop/Database"] = {
            name = "Django",
            description = "Project With Django",
            file_name = "manage.py",
            command = "cd $dir && python3 manage.py makemigrations --settings-Database.settings-dev && python manage.py migrate --settings=Database.settings-dev && python manage.py runserver --settings=Database.settings-dev"

        },
    },

}

code_runner.setup(options)
