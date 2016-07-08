var NewPoll = React.createClass({
  getInitialState: function() {
    return {
      options: ["", "", "", ""]
    }
  },
  addOption: function(e) {
    e.preventDefault();
    this.state.options.push("")
    this.setState({
      options: this.state.options
    });
  },
  removeOption: function(index) {
    this.state.options.splice(index, 1);
    this.setState({
      options: this.state.options
    });
  },
  handleChange: function(index, e) {
    this.state.options[index] = e.target.value;
    this.setState({
      options: this.state.options
    });
  },
  render: function() {
    let remove = this.removeOption;
    let handleOptionChange = this.handleChange;
    let options = this.state.options;
    var optionsInputs = this.state.options.map(function(option, index) {
      return (
        <div className="row" key={index}>
          <div className="col s1">
            <a className="btn-floating btn-large red" onClick={() => remove(index)}>
              <i className="material-icons">delete</i>
            </a>
          </div>
          <div className="col s11">
            <input key={index} id={index} name="poll[options][]" type="text" onChange={(evt) => handleOptionChange(index, evt)} value={options[index]} placeholder="Write option here"/>
          </div>
          <br />
        </div>
      );
    });
    return (
      <div className="row">
        <form className="col s12" action="/polls" id="new_poll" method="post">
          <input name="authenticity_token" type="hidden" value={this.props.authenticity_token} />
          <div className="input-field">
            <input id="poll_title" name="poll[title]" type="text" /><br />
            <label for="poll_title">Title</label>
          </div>
          <label>Options:</label>
          <br />
          {optionsInputs}
          <a className="btn" onClick={this.addOption}>
            Add Option
          </a>
          <p>
            <input type="radio" name="poll[public]" value="false" id="false" />
            <label for="false">Private</label>
          </p>
          <p>
            <input type="radio" name="poll[public]" value="true" id="true" />
            <label for="true">Public</label>
          </p>
          <button className="btn" name="commit" type="submit" value="Create Poll">
            Submit
            <i className="material-icons right">send</i>
          </button>
        </form>
      </div>
    );
  }
});